defmodule Teac.Api.Channels.AdsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Channels.Ads

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Ads.get(broadcaster_id: "1", token: "token") == {:ok, %{}}
    assert Ads.get(broadcaster_id: "1", token: "token", client_id: "asdf") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Ads.get(token: "asdf") ==
             {:error, [broadcaster_id: {"can't be blank", [validation: :required]}]}

    assert Ads.get(broadcaster_id: 1, token: "asdf") ==
             {:error, [broadcaster_id: {"is invalid", [type: :string, validation: :cast]}]}

    assert Ads.get(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end

  test "post/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Ads.post(form: %{broadcaster_id: "1", length: 1}, token: "token") == {:ok, %{}}

    assert Ads.post(form: %{broadcaster_id: "1", length: 1}, token: "token", client_id: "asdf") ==
             {:ok, %{}}
  end

  test "post/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Ads.post(form: %{broadcaster_id: "1", length: 1}) ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert Ads.post(token: "token") == {:error, [form: {"Requires a form argument", []}]}

    assert Ads.post(form: %{broadcaster_id: "1", length: 0}, token: "token") ==
             {:error,
              [
                form: [
                  length:
                    {"must be greater than %{number}",
                     [validation: :number, kind: :greater_than, number: 0]}
                ]
              ]}

    assert Ads.post(form: %{broadcaster_id: "1"}, token: "token") ==
             {:error, [form: [length: {"can't be blank", [validation: :required]}]]}

    assert Ads.post(form: %{length: 1}, token: "token", client_id: "asdf") ==
             {:error, [form: [broadcaster_id: {"can't be blank", [validation: :required]}]]}
  end
end
