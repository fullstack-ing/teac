defmodule Teac.Api.Chat.Color do
  alias Teac.Api
  import Ecto.Changeset

  @color_labels [
    "blue",
    "blue_violet",
    "cadet_blue",
    "chocolate",
    "coral",
    "dodger_blue",
    "firebrick",
    "golden_rod",
    "green",
    "hot_pink",
    "orange_red",
    "red",
    "sea_green",
    "spring_green",
    "yellow_green"
  ]

  @doc """
  Gets the color used for the user’s name in chat.

  ## Authorization
  Requires an app access token or user access token.

  ## Opts params
  * token: String - required
  * client_id: String - optional (defaults)
  * user_ids: List of string - required
  Max 100 ids

  """
  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id, user_id: user_id}} ->
        [
          base_url: Api.uri("chat/color"),
          params: [user_id: user_id],
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
      user_id: :string
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id, :user_id])

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  def put(opts) do
    case validate_put_opts(opts) do
      {:ok, %{token: token, client_id: client_id, user_id: user_id} = cs} ->
        color_hex =
          if Map.get(cs, :color_hex, nil) do
            [{:color, Map.get(cs, :color_hex, nil)}]
          else
            []
          end

        color_label =
          if Map.get(cs, :color_label, nil) do
            [{:color, Map.get(cs, :color_label, nil)}]
          else
            []
          end

        [
          base_url: Api.uri("chat/color"),
          params: [user_id: user_id] ++ color_hex ++ color_label,
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.put!()
        |> Api.handle_response()

      error ->
        error
    end
  end

  defp validate_put_opts(opt) do
    data = %{}

    types = %{
      token: :string,
      client_id: :string,
      user_id: :string,
      color_label: :string,
      color_hex: :string
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id, :user_id])
      |> validate_includes_at_least_one_param()
      |> validate_inclusion(:color_label, @color_labels)
      |> validate_format(:color_hex, ~r/^#(?:[0-9a-f]{3}){1,2}$/i)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  def validate_includes_at_least_one_param(%{changes: changes} = cs) do
    case Map.get(changes, :color_label) || Map.get(changes, :color_hex) do
      nil ->
        cs
        |> add_error(
          :params,
          "Requires at least one of these params 'color_label' or 'color_hex'"
        )

      _ ->
        cs
    end
  end
end
