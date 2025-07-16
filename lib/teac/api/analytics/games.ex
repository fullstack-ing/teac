defmodule Teac.Api.Analytics.Games do
  alias Teac.Api
  import Ecto.Changeset

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id} = cs} ->
        params =
          [
            game_id: Map.get(cs, :game_id, nil),
            type: Map.get(cs, :type, nil),
            started_at: Map.get(cs, :started_at, nil),
            end_at: Map.get(cs, :end_at, nil),
            first: Map.get(cs, :first, nil),
            after: Map.get(cs, :after, nil)
          ]
          |> Enum.filter(fn {_, k} -> k != nil end)

        [
          base_url: Api.uri("analytics/games"),
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

    types = %{
      token: :string,
      client_id: :string,
      type: :string,
      game_id: :string,
      started_at: :string,
      end_at: :string,
      first: :integer,
      after: :string
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id])
      |> validate_inclusion(:type, ["overview_v2"])
      |> validate_number(:first, greater_than: 0, less_than: 101)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end
end
