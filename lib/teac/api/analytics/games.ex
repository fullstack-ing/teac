defmodule Teac.Api.Analytics.Games do
  @doc """
  Gets an analytics report for one or more games. The response contains the URLs used to download the reports (CSV files). Learn more

  ## Authorization
  Requires a user access token that includes the analytics:read:games scope.
  """
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    case Req.get!(Teac.api_uri() <> "analytics/games",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id}
           ],
           params: []
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
