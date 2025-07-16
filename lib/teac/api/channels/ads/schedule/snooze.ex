defmodule Teac.Api.Channels.Ads.Schedule.Snooze do
  import Ecto.Changeset
  alias Teac.Api

  @doc """
  If available, pushes back the timestamp of the upcoming automatic mid-roll ad by 5 minutes.    \
  This endpoint duplicates the snooze functionality in the creator dashboard’s Ads Manager.

  ## Authorization
  Requires a user access token that includes the `channel:manage:ads` scope.   \
  The `user_id` in the user access token must match the `broadcaster_id`.

  ## Opts arguments
  * token: String - required
  * client_id: String - optional (defaults)
  * broadcaster_id: String - required
  """
  def post(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id, broadcaster_id: broadcaster_id}} ->
        [
          base_url: Api.uri("channels/ads/schedule/snooze"),
          params: [broadcaster_id: broadcaster_id],
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.post!()
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
end
