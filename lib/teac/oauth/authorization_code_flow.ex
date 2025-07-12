defmodule Teac.OAuth.AuthorizationCodeFlow do
  @moduledoc """
  Twitch OAuth client for user token via the code grant flow.
  """

  @default_headers [{"Content-Type", "application/x-www-form-urlencoded"}]

  def authorize_url() do
    authorize_url(
      client_id: Teac.client_id(),
      state: Teac.random_string(),
      response_type: "code",
      redirect_uri: Teac.redirect_uri(),
      scopes: scopes()
    )
  end

  def authorize_url(
        client_id: client_id,
        state: state,
        response_type: response_type,
        redirect_uri: redirect_uri,
        scopes: scopes
      ) do
    query_params = [
      client_id: client_id,
      state: state,
      response_type: response_type,
      redirect_uri: redirect_uri,
      scope: scopes |> Enum.join(" ")
    ]

    "https://id.twitch.tv/oauth2/authorize?" <> URI.encode_query(query_params)
  end

  def exchange_code_for_token(opts) do
    code = Keyword.fetch!(opts, :code)

    get_token(
      client_id: Teac.client_id(),
      client_secret: Teac.client_secret(),
      code: code,
      redirect_uri: Teac.redirect_uri()
    )
  end

  def get_token(
        client_id: client_id,
        client_secret: client_secret,
        code: code,
        redirect_uri: redirect_uri
      ) do
    Req.post(
      url: "https://id.twitch.tv/oauth2/token",
      form: [
        client_id: client_id,
        client_secret: client_secret,
        code: code,
        grant_type: "authorization_code",
        redirect_uri: redirect_uri
      ],
      headers: @default_headers,
      receive_timeout: 15_000,
      decode_body: :json
    )
    |> handle_token_response()
  end

  defp handle_token_response({:ok, %{status: 200, body: body}}), do: {:ok, body}

  defp handle_token_response({:ok, %{status: status, body: body}}),
    do: {:error, {:http_error, status, body}}

  defp handle_token_response({:error, reason}), do: {:error, reason}

  defp scopes(), do: Teac.Scopes.all_values()
end
