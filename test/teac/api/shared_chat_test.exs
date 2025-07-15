defmodule Teac.Api.SharedChatTest do
  use ExUnit.Case, async: true
  alias Teac.Api.SharedChat

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert SharedChat.get(broadcaster_id: "1", token: "token") == {:ok, %{}}
    assert SharedChat.get(broadcaster_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert SharedChat.get(token: "asdf") ==
             {:error, [broadcaster_id: {"can't be blank", [validation: :required]}]}

    assert SharedChat.get(broadcaster_id: 1, token: "asdf") ==
             {:error, [broadcaster_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert SharedChat.get(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
