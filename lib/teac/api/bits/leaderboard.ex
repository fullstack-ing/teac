defmodule Teac.Api.Bits.Leaderboard do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    params = []

    params =
      case Keyword.get(opts, :count) do
        nil -> params
        count -> params ++ [count: count]
      end

    params =
      case Keyword.get(opts, :period) do
        nil ->
          params

        period ->
          if period in ["day", "week", "month", "year", "all"] do
            params ++ [period: period]
          else
            period
          end
      end

    params =
      case Keyword.get(opts, :started_at) do
        nil -> params
        started_at -> params ++ [started_at: started_at]
      end

    params =
      case Keyword.get(opts, :user_id) do
        nil -> params
        user_id -> params ++ [user_id: user_id]
      end

    case Req.get!(Teac.api_uri() <> "bits/leaderboard",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id}
           ],
           params: params
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
