defmodule Teac.Api.Bits.Leaderboard do
  alias Teac.Api
  import Ecto.Changeset

  @doc """
  Gets the Bits leaderboard for the authenticated broadcaster.

  ## Authorization
  Requires a user access token that includes the `bits:read` scope.


  """
  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id} = cs} ->
        params =
          [
            count: Map.get(cs, :game_id, nil),
            period: Map.get(cs, :type, nil),
            started_at: Map.get(cs, :started_at, nil),
            user_id: Map.get(cs, :end_at, nil)
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
      count: :integer,
      period: :string,
      started_at: :string,
      user_id: :string
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id])
      |> validate_inclusion(:period, ["day", "week", "month", "year", "all"])
      |> validate_number(:count, greater_than: 0, less_than: 101)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end
end
