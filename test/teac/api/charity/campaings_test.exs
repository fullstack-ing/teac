defmodule Teac.Api.Charity.CampaingsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Charity.Campaings

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Campaings.get(broadcaster_id: "1", token: "token") == {:ok, %{}}
    assert Campaings.get(broadcaster_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Campaings.get(token: "asdf") ==
             {:error, [broadcaster_id: {"can't be blank", [validation: :required]}]}

    assert Campaings.get(broadcaster_id: 1, token: "asdf") ==
             {:error, [broadcaster_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert Campaings.get(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
