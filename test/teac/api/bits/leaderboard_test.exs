defmodule Teac.Api.Bits.LeaderboardsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Bits.Leaderboard

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Leaderboard.get(token: "token") == {:ok, %{}}
    assert Leaderboard.get(token: "token", client_id: "asdf") == {:ok, %{}}
    assert Leaderboard.get(token: "token", count: 1) == {:ok, %{}}
    assert Leaderboard.get(token: "token", period: "day") == {:ok, %{}}
    assert Leaderboard.get(token: "token", period: "week") == {:ok, %{}}
    assert Leaderboard.get(token: "token", period: "month") == {:ok, %{}}
    assert Leaderboard.get(token: "token", period: "year") == {:ok, %{}}
    assert Leaderboard.get(token: "token", period: "all") == {:ok, %{}}
    assert Leaderboard.get(token: "token", started_at: "2021-10-27T00:00:00Z") == {:ok, %{}}
    assert Leaderboard.get(token: "token", user_id: "1") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Leaderboard.get([]) ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert Leaderboard.get(token: "token", count: 101) ==
             {:error,
              [
                count:
                  {"must be less than %{number}",
                   [validation: :number, kind: :less_than, number: 101]}
              ]}

    assert Leaderboard.get(token: "token", count: 0) ==
             {:error,
              [
                count:
                  {"must be greater than %{number}",
                   [validation: :number, kind: :greater_than, number: 0]}
              ]}

    assert Leaderboard.get(token: "token", period: "foo") ==
             {:error,
              [
                period:
                  {"is invalid",
                   [validation: :inclusion, enum: ["day", "week", "month", "year", "all"]]}
              ]}
  end
end
