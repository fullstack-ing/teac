defmodule Teac.MockApi do
  @moduledoc """
  This module is used for all the /unit enpoints on the mock server
  """
  def categories(), do: request("categories")
  def clients(), do: request("clients")
  def streams(), do: request("streams")
  def subscriptions(), do: request("subscriptions")
  def tags(), do: request("tags")
  def teams(), do: request("teams")
  def users(), do: request("users")
  def videos(), do: request("videos")

  defp request(endpoint) do
    case Req.get!(mock_units() <> endpoint,
           params: []
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end

  defp mock_units() do
    Application.get_env(:teac, :mock_units)
  end
end
