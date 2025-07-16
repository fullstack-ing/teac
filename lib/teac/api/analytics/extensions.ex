defmodule Teac.Api.Analytics.Extensions do
  alias Teac.Api
  import Ecto.Changeset

  @doc """
  # Get Extension Analytics
  Gets an analytics report for one or more extensions. The response contains the URLs used to download the reports (CSV files).

  From https://dev.twitch.tv/docs/api/reference/#get-extension-analytics

  ### Authorization
  Requires a user access token that includes the `analytics:read:extensions` scope.

  ### Opts Arguments
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
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id} = cs} ->
        params =
          [
            extension_id: Map.get(cs, :extension_id, nil),
            type: Map.get(cs, :type, nil),
            started_at: Map.get(cs, :started_at, nil),
            end_at: Map.get(cs, :end_at, nil),
            first: Map.get(cs, :first, nil),
            after: Map.get(cs, :after, nil)
          ]
          |> Enum.filter(fn {_, k} -> k != nil end)

        [
          base_url: Api.uri("analytics/extensions"),
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
      extension_id: :string,
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
