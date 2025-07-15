defmodule Teac.Api.Chat.Emotes.SetTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Chat.Emotes.Set

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Set.get(emote_set_id: "1", token: "token") == {:ok, %{}}
    assert Set.get(emote_set_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Set.get(token: "asdf") ==
             {:error, [emote_set_id: {"can't be blank", [validation: :required]}]}

    assert Set.get(emote_set_id: 1, token: "asdf") ==
             {:error, [emote_set_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert Set.get(emote_set_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
