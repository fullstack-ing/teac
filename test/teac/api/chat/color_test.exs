defmodule Teac.Api.Chat.ColorTest do
  use ExUnit.Case, async: true

  alias Teac.Api.Chat.Color

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Color.get(user_id: "asdf", token: "token") == {:ok, %{}}
    assert Color.get(user_id: "asdf", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Color.get(user_id: "asdf") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert Color.get(token: "token") ==
             {:error, [user_id: {"can't be blank", [validation: :required]}]}
  end

  test "put/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Color.put(color_label: "green", user_id: "asdf", token: "token") == {:ok, %{}}
    assert Color.put(color_hex: "#AABBFF", user_id: "asdf", token: "token") == {:ok, %{}}

    assert Color.put(color_hex: "#AABBFF", color_label: "green", user_id: "asdf", token: "token") ==
             {:ok, %{}}
  end

  test "put/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Color.put(color_label: "green", token: "token") ==
             {:error, [user_id: {"can't be blank", [validation: :required]}]}

    assert Color.put(color_label: "green", user_id: "asdf") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert Color.put(user_id: "asdf", token: "token") ==
             {:error,
              [params: {"Requires at least one of these params 'color_label' or 'color_hex'", []}]}

    assert Color.put(color_hex: "green", user_id: "asdf") ==
             {:error,
              [
                {:color_hex, {"has invalid format", [validation: :format]}},
                {:token, {"can't be blank", [validation: :required]}}
              ]}

    assert Color.put(color_label: "foo", user_id: "asdf", token: "token") ==
             {:error,
              [
                color_label:
                  {"is invalid",
                   [
                     {:validation, :inclusion},
                     {:enum,
                      [
                        "blue",
                        "blue_violet",
                        "cadet_blue",
                        "chocolate",
                        "coral",
                        "dodger_blue",
                        "firebrick",
                        "golden_rod",
                        "green",
                        "hot_pink",
                        "orange_red",
                        "red",
                        "sea_green",
                        "spring_green",
                        "yellow_green"
                      ]}
                   ]}
              ]}
  end
end
