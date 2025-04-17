defmodule Teac.OAuth.ClientCredentialFlow do
  @doc """
  Client credentials grant flow
  The client credentials grant flow is meant only for server-to-server
  API requests that use an app access token.

  [Api Doc link](https://dev.twitch.tv/docs/authentication/getting-tokens-oauth/#client-credentials-grant-flow)
  """
  def token(opts \\ []) do
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    client_secret = Keyword.get(opts, :client_secret, Teac.client_secret())
    grant_type = "client_credentials"

    case Req.post!(Teac.auth_uri() <> "token",
           headers: [
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           form: [
             client_id: client_id,
             client_secret: client_secret,
             grant_type: grant_type
           ],
           decode_body: :json
         ) do
      %Req.Response{status: 200, body: data} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
