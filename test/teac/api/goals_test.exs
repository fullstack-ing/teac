defmodule Teac.Api.GoalsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Goals

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Goals.get(broadcaster_id: "1", token: "token") == {:ok, %{}}
    assert Goals.get(broadcaster_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Goals.get(token: "asdf") ==
             {:error, [broadcaster_id: {"can't be blank", [validation: :required]}]}

    assert Goals.get(broadcaster_id: 1, token: "asdf") ==
             {:error, [broadcaster_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert Goals.get(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
