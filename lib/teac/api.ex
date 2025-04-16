defmodule Teac.Api do
  def api_uri do
    Application.get_env(:teac, :api_uri)
  end
end
