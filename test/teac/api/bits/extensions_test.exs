defmodule Teac.Api.Bits.ExtensionsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Bits.Extensions

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Extensions.get(should_include_all: true, token: "token") == {:ok, %{}}
    assert Extensions.get(should_include_all: false, token: "token") == {:ok, %{}}
    assert Extensions.get(token: "token") == {:ok, %{}}
    assert Extensions.get(token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Extensions.get(should_include_all: 1, token: "asdf") ==
             {:error, [should_include_all: {"is invalid", [type: :boolean, validation: :cast]}]}

    assert Extensions.get(should_include_all: false) ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end

  test "put/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    # fixme
    assert false
  end
end
