alias   Teac.Mock

defmodule MockHelper do
  def get_app_access_token() do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Mock.Api.clients()
    {:ok, %{"access_token" => access_token}} = Mock.Auth.fetch_app_access_token([client_id: client_id, client_secret: client_secret])
    [token: access_token, client_id: client_id, client_secret: client_secret]
  end

  def get_user(broadcaster_type \\ "") do
    {:ok, users} = Mock.Api.users()
    Enum.find(users, fn %{"broadcaster_type" => bt} -> bt == broadcaster_type end)
  end

  def get_user_access_token(%{"id" => user_id}, scopes \\ nil) do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Mock.Api.clients()
    opts = [client_id: client_id, client_secret: client_secret, user_id: user_id, scope: scopes]
    {:ok, %{"access_token" => access_token}} = Mock.Auth.fetch_user_access_token(opts)
    [token: access_token, client_id: client_id, client_secret: client_secret]
  end
end
