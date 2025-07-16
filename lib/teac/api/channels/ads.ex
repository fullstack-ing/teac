defmodule Teac.Api.Channels.Ads do
  defmodule Form do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key false
    @derive Jason.Encoder
    embedded_schema do
      field(:broadcaster_id, :string)
      field(:length, :integer)
    end

    def changeset(form, attrs) do
      form
      |> cast(attrs, [
        :broadcaster_id,
        :length
      ])
      |> validate_required([:broadcaster_id, :length])
      |> validate_number(:length, less_than: 180, greater_than: 0)
    end
  end

  defmodule PostParams do
    use Ecto.Schema
    import Ecto.Changeset
    alias Teac.Api.Channels.Ads.Form

    @primary_key false
    @derive Jason.Encoder
    embedded_schema do
      field(:token, :string)
      field(:client_id, :string)
      embeds_one(:form, Form)
    end

    def changeset(params, attrs) do
      params
      |> cast(attrs, [:token, :client_id])
      |> Teac.Api.default_client_id()
      |> validate_required([:token, :client_id])
      |> cast_embed(:form, with: &Form.changeset/2)
      |> validate_requires_form()
    end

    def validate_requires_form(%{changes: %{form: _form}} = cs), do: cs
    def validate_requires_form(cs), do: add_error(cs, :form, "Requires a form argument")
  end

  import Ecto.Changeset
  alias Teac.Api
  alias Teac.Api.Channels.Ads.PostParams

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id, broadcaster_id: broadcaster_id}} ->
        [
          base_url: Api.uri("chat/channels/ads"),
          params: [broadcaster_id: broadcaster_id],
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

    types = %{
      token: :string,
      client_id: :string,
      broadcaster_id: :string
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id, :broadcaster_id])

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  @doc """
  Starts a commercial on the specified channel.

  NOTE: Only partners and affiliates may run commercials and they must be streaming live at the time.
  NOTE: Only the broadcaster may start a commercial; the broadcaster’s editors and moderators may not start commercials on behalf of the broadcaster.

  ## Authorization
  Requires a user access token that includes the channel:edit:commercial scope.

  ## Opts params

  * token: String - required
  * client_id: String - optional (defaults)
  * form: Map - required
      A form has the following keys.
      * broadcaster_id: String - required
      * length: Integer - required - Length of Ad.

  ## Examples

      iex> Teac.Api.Channels.Ads.post(token: "some_token", form: %{broadcaster_id: "some_id", length: 60})
      -> {:ok, %{"length" => 0, "message" => "some message", "retry_after" => 0 }}

  ## Results:

  * length: Integer -	The length of the commercial you requested. If you request a commercial that’s longer than 180 seconds, the API uses 180 seconds.
  * message: String - A message that indicates whether Twitch was able to serve an ad.
  * retry_after: Integer - The number of seconds you must wait before running another commercial.
  """

  def post(opts) do
    data =
      %PostParams{}
      |> PostParams.changeset(Map.new(opts))
      |> apply_action(:insert)

    case data do
      {:ok, %{form: form, token: token, client_id: client_id}} ->
        [
          base_url: Api.uri("channels"),
          json: form,
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.post!()
        |> Api.handle_response()

      {:error, %Ecto.Changeset{} = changeset} ->
        errors =
          if Map.get(changeset.changes, :form, %{errors: []}).errors == [] do
            changeset.errors
          else
            changeset.errors |> Keyword.merge(form: changeset.changes.form.errors)
          end

        {:error, errors}
    end
  end
end
