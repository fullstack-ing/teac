defmodule Teac.Api.Channels.Ads do
  alias Teac.Api
  import Ecto.Changeset

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
end
