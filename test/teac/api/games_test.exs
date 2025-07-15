defmodule Teac.Api.GamesTest do
  alias Teac.Api.Games
  use ExUnit.Case, async: true

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Games.get(ids: ["1"], token: "token") == {:ok, %{}}
    assert Games.get(names: ["foo", "bar"], token: "token") == {:ok, %{}}
    assert Games.get(igdb_ids: ["1", "2", "3"], token: "token", client_id: "asdf") == {:ok, %{}}

    assert Games.get(
             ids: 1..33 |> Enum.map(&to_string/1),
             names: 1..33 |> Enum.map(&to_string/1),
             igdb_ids: 1..33 |> Enum.map(&to_string/1),
             token: "token"
           ) == {:ok, %{}}
  end

  test "get/2 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Games.get(token: "token") ==
             {:error,
              [
                params:
                  {"Requires at least one of these params 'ids', 'names' and or 'igdb_ids'", []}
              ]}

    assert Games.get(ids: 1..101 |> Enum.map(&to_string/1), token: "token") ==
             {:error, [params: {"Exceeds more than 100 'ids', 'names' and or 'igdb_ids'", []}]}

    assert Games.get(
             ids: 1..33 |> Enum.map(&to_string/1),
             names: 1..33 |> Enum.map(&to_string/1),
             igdb_ids: 1..36 |> Enum.map(&to_string/1),
             token: "token"
           ) ==
             {:error, [params: {"Exceeds more than 100 'ids', 'names' and or 'igdb_ids'", []}]}
  end
end
