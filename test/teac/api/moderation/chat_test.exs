defmodule Teac.Api.Moderation.ChatTest do
  use ExUnit.Case, async: true

  test "delete/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    # fixme
    assert false
  end
end
