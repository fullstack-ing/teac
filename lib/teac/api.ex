defmodule Teac.Api do
  @moduledoc false

  import Ecto.Changeset, only: [put_change: 3]

  @type broadcaster_ids :: [integer()]

  @type token :: String.t()
  @type client_id :: String.t() | nil

  @type ok :: {:ok, map()}
  @type error :: {:error, map()}

  def uri(path) do
    Teac.api_uri() <> path
  end

  def headers(token, client_id) do
    [{"Authorization", "Bearer #{token}"}, {"Client-Id", client_id}]
  end

  def handle_response(rsp) do
    case rsp do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{status: 204, body: ""} -> {:ok, "ok"}
      %Req.Response{body: body} -> {:error, body}
    end
  end

  def default_client_id(%{changes: %{client_id: _}} = cs), do: cs
  def default_client_id(cs), do: cs |> put_change(:client_id, Teac.client_id())
end
