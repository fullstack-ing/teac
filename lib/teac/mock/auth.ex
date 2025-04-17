defmodule Teac.Mock.Auth do
  @moduledoc """
  This module is used when using the twitch cli mock server.
  The flow for getting a user token / app token is diffrent enough
  it required its own module.

  https://dev.twitch.tv/docs/cli/mock-api-command/#getting-an-access-token
  """

  def fetch_user_access_token(opts) do
    request("authorize",
      user_id: Keyword.fetch!(opts, :user_id),
      client_secret: Keyword.get(opts, :client_secret, Teac.client_secret()),
      client_id: Keyword.get(opts, :client_id, Teac.client_id()),
      grant_type: "user_token",
      scope: Keyword.fetch!(opts, :scope)
    )
  end

  def fetch_app_access_token(opts) do
    request("token",
      client_secret: Keyword.get(opts, :client_secret, Teac.client_secret()),
      client_id: Keyword.get(opts, :client_id, Teac.client_id()),
      grant_type: "client_credentials"
    )
  end

  defp request(endpoint, params) do
    case Req.post!(auth_uri() <> endpoint, params: params) do
      %Req.Response{status: 200, body: body} -> {:ok, body}
      %Req.Response{body: body} -> {:error, body}
    end
  end

  defp auth_uri() do
    Application.get_env(:teac, :auth_uri)
  end
end
