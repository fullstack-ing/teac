defmodule Teac.Api.WhipsersTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Whipsers

  @args [
    token: "token",
    client_id: "asdf",
    from_user_id: "asdf",
    to_user_id: "asdf",
    message: "asdf"
  ]

  test "post/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Whipsers.post(@args) == {:ok, %{}}
    assert Whipsers.post(@args |> Keyword.delete(:client_id)) == {:ok, %{}}
  end

  test "post/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Whipsers.post(@args) == {:ok, %{}}
  end
end
