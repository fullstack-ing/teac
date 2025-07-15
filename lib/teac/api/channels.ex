defmodule Teac.Api.Channels do
  defmodule ContentClassificationLabel do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key false
    @derive Jason.Encoder
    embedded_schema do
      field(:id, :string)
      field(:is_enabled, :boolean)
    end

    def changeset(form, attrs) do
      form
      |> cast(attrs, [
        :id,
        :is_enabled
      ])
    end
  end

  defmodule Form do
    use Ecto.Schema
    import Ecto.Changeset
    alias Teac.Api.Channels.ContentClassificationLabel

    @primary_key false
    @derive Jason.Encoder
    embedded_schema do
      field(:game_id, :string)
      field(:broadcaster_language, :string)
      field(:title, :string)
      field(:delay, :integer)
      field(:tags, {:array, :string})
      field(:is_branded_content, :boolean)
      field(:is_rerun, :boolean)
      embeds_many(:content_classification_labels, ContentClassificationLabel)
    end

    def changeset(form, attrs) do
      form
      |> cast(attrs, [
        :game_id,
        :broadcaster_language,
        :title,
        :delay,
        :tags,
        :is_branded_content
      ])
      |> cast_embed(:content_classification_labels,
        with: &ContentClassificationLabel.changeset/2
      )
    end
  end

  defmodule PatchParams do
    use Ecto.Schema
    import Ecto.Changeset
    alias Teac.Api.Channels.Form

    @primary_key false
    @derive Jason.Encoder
    embedded_schema do
      field(:broadcaster_id, :integer)
      field(:token, :string)
      field(:client_id, :string)
      embeds_one(:form, Form)
    end

    def changeset(params, attrs) do
      params
      |> cast(attrs, [:broadcaster_id, :token, :client_id])
      |> Teac.Api.default_client_id()
      |> validate_required([:broadcaster_id, :token, :client_id])
      |> cast_embed(:form, with: &Form.changeset/2)
    end
  end

  alias Teac.Api
  alias Teac.Api.Channels.PatchParams
  import Ecto.Changeset

  @doc """
  Gets information about one or more channels.

  #### Authorization
  Requires an app access token or user access token.

  ### Opts Arrgument keys

  * broadcaster_ids : required    \
  list of one of more broadcaster_ids   \
  Max 100 IDs, ignores duplicates and not found.

  * token : required (app or user)

  * client_id : optinal (defaults to Teac.client_id())

  ### Examples

      iex> Teac.Api.Channels.get([123, 234], "some_token")
      iex> Teac.Api.Channels.get([123, 234], "some_token", "some_client_id")

      {:ok,
        {
          "broadcaster_id" =>  "1",
          "broadcaster_login" =>  "twitchdev",
          "broadcaster_name" =>  "TwitchDev",
          "broadcaster_language" =>  "en",
          "game_id" =>  "509670",
          "game_name" =>  "Science & Technology",
          "title" =>  "TwitchDev Monthly Update // May 6, 2021",
          "delay" =>  0,
          "tags" =>  ["DevsInTheKnow"],
          "content_classification_labels" => ["Gambling", "DrugsIntoxication", "MatureGame"],
          "is_branded_content" =>  false
        }...
      }
  """

  @spec get(
          opts :: [broadcaster_ids: [integer()], token: String.t(), client_id: String.t() | nil]
        ) :: {:ok, map()} | {:error, any()}
  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{broadcaster_ids: broadcaster_ids, token: token, client_id: client_id}} ->
        params =
          broadcaster_ids
          |> Enum.map(&to_string/1)
          |> Enum.map(&{:broadcaster_id, &1})

        [
          base_url: Api.uri("channels"),
          params: params,
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.get!()
        |> Api.handle_response()

      error ->
        error
    end
  end

  defp validate_get_opts(opt) do
    data = %{}
    types = %{token: :string, client_id: :string, broadcaster_ids: {:array, :string}}

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id, :broadcaster_ids])
      |> validate_length(:broadcaster_ids, min: 1, max: 100)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  @doc """
  Modify Channel Information
  Updates a channel’s properties.

  ## Authorization
  Requires a user access token that includes the channel:manage:broadcast scope.

  ### Opts Arrgument keys
  * token : required user token
  * client_id : optinal (defaults to Teac.client_id())
  * broadcaster_id: String - required

  The ID of the broadcaster whose channel you want to update.    \
  This ID must match the user ID in the user access token.    \

  * form : required - Map (At leaste one key is required)
      - game_id: String - optional - Unset with 0 or ""
      - broadcaster_language: - String - optinal (ISO 639-1 two-letter language code)
      - title: String - optional
      - delay: integer - optional
      - tags: list of strings - optional (max 10 tax, max 25 chars per tag)
      - content_classification_labels - Map - optional
          id: String - required
            can be one of the following:
            * DebatedSocialIssuesAndPolitics
            * DrugsIntoxication
            * SexualThemes
            * ViolentGraphic
            * Gambling
            * ProfanityVulgarity
          is_enabled: boolean - required
      - is_branded_content: boolean - optional
  """
  @spec get(opts :: [broadcaster_id: String.t(), token: String.t(), client_id: String.t() | nil]) ::
          {:ok, map()} | {:error, any()}
  def patch(opts) do
    data =
      %PatchParams{}
      |> PatchParams.changeset(Map.new(opts))
      |> apply_action(:insert)

    case data do
      {:ok, %{broadcaster_id: broadcaster_id, form: form, token: token, client_id: client_id}} ->
        [
          base_url: Api.uri("channels"),
          params: [broadcaster_id: broadcaster_id],
          json: form,
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.patch!()
        |> Api.handle_response()

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset.errors}
    end
  end
end
