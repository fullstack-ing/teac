defmodule Teac.Api.Analytics.ExtensionsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Analytics.Extensions

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Extensions.get(token: "token") == {:ok, %{}}
    assert Extensions.get(token: "token", client_id: "asdf") == {:ok, %{}}
    assert Extensions.get(token: "token", type: "overview_v2") == {:ok, %{}}
    assert Extensions.get(token: "token", extension_id: "1") == {:ok, %{}}
    assert Extensions.get(token: "token", ended_at: "2021-10-27T00:00:00Z") == {:ok, %{}}
    assert Extensions.get(token: "token", started_at: "2021-10-27T00:00:00Z") == {:ok, %{}}
    assert Extensions.get(token: "token", first: 100) == {:ok, %{}}
    assert Extensions.get(token: "token", first: 1) == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert Extensions.get(broadcaster_id: "1") ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert Extensions.get(token: "token", first: 101) ==
             {:error,
              [
                first:
                  {"must be less than %{number}",
                   [validation: :number, kind: :less_than, number: 101]}
              ]}

    assert Extensions.get(token: "token", first: 0) ==
             {:error,
              [
                first:
                  {"must be greater than %{number}",
                   [validation: :number, kind: :greater_than, number: 0]}
              ]}
  end
end
