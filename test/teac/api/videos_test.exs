defmodule Teac.Api.VideosTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Videos

  @args [
    token: "token",
    client_id: "asdf",
    ids: ["asdf"],
    user_id: "user_id",
    game_id: "game_id",
    language: "language",
    period: "all",
    sort: "time",
    type: "all",
    first: 1,
    after: "1",
    before: "1"
  ]

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Videos.get(@args) == {:ok, %{}}
    assert Videos.get(@args |> Keyword.delete(:client_id)) == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Videos.get(@args |> Keyword.delete(:token)) ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert Videos.get(@args |> Keyword.delete(:ids)) ==
             {:error, [ids: {"can't be blank", [validation: :required]}]}

    assert Videos.get(@args |> Keyword.delete(:user_id)) ==
             {:error, [user_id: {"can't be blank", [validation: :required]}]}

    assert Videos.get(@args |> Keyword.delete(:game_id)) ==
             {:error, [game_id: {"can't be blank", [validation: :required]}]}

    assert Videos.get(
             ids: ["asdf"],
             user_id: "asdf",
             game_id: "asdf",
             token: "asdf",
             period: "foo"
           ) ==
             {:error,
              [
                period:
                  {"is invalid",
                   [{:validation, :inclusion}, {:enum, ["all", "day", "week", "month"]}]}
              ]}

    assert Videos.get(
             ids: ["asdf"],
             user_id: "asdf",
             game_id: "asdf",
             token: "asdf",
             type: "foo"
           ) ==
             {:error,
              [
                type:
                  {"is invalid",
                   [validation: :inclusion, enum: ["all", "archive", "highlight", "upload"]]}
              ]}

    assert Videos.get(
             ids: ["asdf"],
             user_id: "asdf",
             game_id: "asdf",
             token: "asdf",
             first: 0
           ) ==
             {:error,
              [
                first:
                  {"must be greater than %{number}",
                   [validation: :number, kind: :greater_than, number: 0]}
              ]}

    assert Videos.get(
             ids: ["asdf"],
             user_id: "asdf",
             game_id: "asdf",
             token: "asdf",
             first: 101
           ) ==
             {:error,
              [
                first:
                  {"must be less than %{number}",
                   [validation: :number, kind: :less_than, number: 101]}
              ]}
  end

  test "delete/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    # fixme
    assert false
  end
end
