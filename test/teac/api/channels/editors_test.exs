defmodule Teac.Api.Channels.EditorsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Channels.Editors

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Editors.get(broadcaster_id: "1", token: "token") == {:ok, %{}}
    assert Editors.get(broadcaster_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Editors.get(token: "asdf") ==
             {:error, [broadcaster_id: {"can't be blank", [validation: :required]}]}

    assert Editors.get(broadcaster_id: 1, token: "asdf") ==
             {:error, [broadcaster_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert Editors.get(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
