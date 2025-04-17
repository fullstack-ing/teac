defmodule Teac do
  @moduledoc """
  Documentation for `Teac`.
  """

  def api_uri, do: Application.get_env(:teac, :api_uri)
  def auth_uri, do: Application.get_env(:teac, :auth_uri)
  def client_id, do: Application.get_env(:teac, :client_id)
  def client_secret, do: Application.get_env(:teac, :client_secret)
  def redirect_uri, do: Application.get_env(:teac, :oauth_callback_uri)

  def random_string do
    :crypto.strong_rand_bytes(32)
    |> Base.url_encode64()
    |> String.replace(~r/[\+\/]/, "-")
    |> String.replace(~r/=+$/, "")
  end
end
