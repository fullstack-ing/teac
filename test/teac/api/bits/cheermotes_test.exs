defmodule Teac.Api.Bits.CheermotesTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Bits.Cheermotes

  @mock [
    %{
      "prefix" => "Cheer",
      "tiers" => [
        %{
          "min_bits" => 1,
          "id" => "1",
          "color" => "#979797",
          "images" => %{
            "dark" => %{
              "animated" => %{
                "1" => "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/dark/animated/1/1.gif"
              },
              "static" => %{
                "1" => "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/dark/static/1/1.png"
              }
            },
            "light" => %{
              "animated" => %{
                "1" =>
                  "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/light/animated/1/1.gif"
              },
              "static" => %{
                "1" => "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/light/static/1/1.png"
              }
            }
          },
          "can_cheer" => true,
          "show_in_bits_card" => true
        }
      ],
      "type" => "global_first_party",
      "order" => 1,
      "last_updated" => "2018-05-22T00:06:04Z",
      "is_charitable" => false
    }
  ]

  test "valid get/3" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => @mock})
    end)

    assert Cheermotes.get(token: "token") == {:ok, @mock}
    assert Cheermotes.get(broadcaster_ids: [1], token: "token", client_id: "asdf") == {:ok, @mock}
  end

  test "invalid get/3" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => @mock})
    end)

    assert Cheermotes.get([]) == {:error, [token: {"can't be blank", [validation: :required]}]}
  end
end
