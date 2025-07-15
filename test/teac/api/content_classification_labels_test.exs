defmodule Teac.Api.ContentClassificationLabelsTest do
  alias Teac.Api.ContentClassificationLabels
  use ExUnit.Case, async: true

  test "get/1 valid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert ContentClassificationLabels.get(token: "token") == {:ok, %{}}
    assert ContentClassificationLabels.get(token: "token", client_id: "client_id") == {:ok, %{}}
    assert ContentClassificationLabels.get(locale: "en-US", token: "token") == {:ok, %{}}
  end

  test "get/1 invalid" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => %{}})
    end)

    assert ContentClassificationLabels.get([]) ==
             {:error, [token: {"can't be blank", [validation: :required]}]}

    assert ContentClassificationLabels.get(locale: "foo", token: "token") == {
             :error,
             [
               locale:
                 {"is invalid",
                  [
                    validation: :inclusion,
                    enum: [
                      "en-US",
                      "bg-BG",
                      "cs-CZ",
                      "da-DK",
                      "da-DK",
                      "de-DE",
                      "el-GR",
                      "en-GB",
                      "en-US",
                      "es-ES",
                      "es-MX",
                      "fi-FI",
                      "fr-FR",
                      "hu-HU",
                      "it-IT",
                      "ja-JP",
                      "ko-KR",
                      "nl-NL",
                      "no-NO",
                      "pl-PL",
                      "pt-BT",
                      "pt-PT",
                      "ro-RO",
                      "ru-RU",
                      "sk-SK",
                      "sv-SE",
                      "th-TH",
                      "tr-TR",
                      "vi-VN",
                      "zh-CN",
                      "zh-TW"
                    ]
                  ]}
             ]
           }
  end
end
