defmodule Teac.Api.Moderation.ShieldModeTest do
  use ExUnit.Case, async: true

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    # fixme
    assert false
  end

  test "put/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    # fixme
    assert false
  end
end
