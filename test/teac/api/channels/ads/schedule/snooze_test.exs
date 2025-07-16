defmodule Teac.Api.Channels.Ads.Schedule.SnoozeTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Channels.Ads.Schedule.Snooze

  test "post/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Snooze.post(broadcaster_id: "1", token: "token") == {:ok, %{}}
    assert Snooze.post(broadcaster_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "post/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Snooze.post(token: "asdf") ==
             {:error, [broadcaster_id: {"can't be blank", [validation: :required]}]}

    assert Snooze.post(broadcaster_id: 1, token: "asdf") ==
             {:error, [broadcaster_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert Snooze.post(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
