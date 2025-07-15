defmodule Teac.Api.Chat.Emotes.GlobalTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Chat.Emotes.Global

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Global.get(token: "token") == {:ok, %{}}
    assert Global.get(token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Global.get([]) == {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
