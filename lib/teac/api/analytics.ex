defmodule Teac.Api.Analytics do
  @moduledoc false

  defmodule Extensions do
    @doc """
    # Get Extension Analytics
    Gets an analytics report for one or more extensions. The response contains the URLs used to download the reports (CSV files).

    From https://dev.twitch.tv/docs/api/reference/#get-extension-analytics

    ### Authorization
    Requires a user access token that includes the `analytics:read:extensions` scope.

    ### Parameters
    * extension_id :string, required: false

    The extension's client ID. If specified, the response contains a report for the specified extension. If not specified, the response includes a report for each extension that the authenticated user owns.

    * type :string, required: false

    The type of analytics report to get. Possible values are: `overview_v2`

    * started_at :string, required: false

    The reporting window's start date, in RFC3339 format. Set the time portion to zeroes (for example, 2021-10-22T00:00:00Z).
    The start date must be on or after January 31, 2018. If you specify an earlier date, the API ignores it and uses January 31, 2018.
    If you specify a start date, you must specify an end date. If you don't specify a start and end date, the report includes all available data since January 31, 2018.
    The report contains one row of data for each day in the reporting window.

    * ended_at :string, required: false

    The reporting window's end date, in RFC3339 format. Set the time portion to zeroes (for example, 2021-10-27T00:00:00Z).
    The report is inclusive of the end date. Specify an end date only if you provide a start date.
    Because it can take up to two days for the data to be available, you must specify an end date that's earlier than today minus one to two days.
    If not, the API ignores your end date and uses an end date that is today minus one to two days.
    """
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "analytics/extensions",
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

  defmodule Games do
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
end
