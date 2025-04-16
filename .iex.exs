alias   Teac.MockApi
alias   Teac.MockAuth

defmodule MockHelper do
  def get_app_access_token() do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()
    {:ok, %{"access_token" => access_token}} = Teac.MockAuth.fetch_app_access_token([client_id: client_id, client_secret: client_secret])
    %{app_access_token: access_token, client_id: client_id, client_secret: client_secret}
  end

  def get_user(broadcaster_type \\ "") do
    {:ok, users} = Teac.MockApi.users()
    Enum.find(users, fn %{"broadcaster_type" => bt} -> bt == broadcaster_type end)
  end

  def get_user_access_token(scopes \\ nil)
  def get_user_access_token(scopes), do: get_user() |> get_user_access_token(scopes)
  def get_user_access_token(%{"id" => user_id}, scopes) do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()
    opts = [client_id: client_id, client_secret: client_secret, user_id: user_id, scope: scopes]
    {:ok, %{"access_token" => access_token}} = Teac.MockAuth.fetch_user_access_token(opts)
    %{user_access_token: access_token, client_id: client_id, client_secret: client_secret}
  end
end
