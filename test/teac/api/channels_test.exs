defmodule Api.ChannelsTest do
  use ExUnit.Case, async: true
  alias Teac.Api.Channels

  @mock %{
    "broadcaster_id" => "1",
    "broadcaster_login" => "twitchdev",
    "broadcaster_name" => "TwitchDev",
    "broadcaster_language" => "en",
    "game_id" => "509670",
    "game_name" => "Science & Technology",
    "title" => "TwitchDev Monthly Update // May 6, 2021",
    "delay" => 0,
    "tags" => ["DevsInTheKnow"],
    "content_classification_labels" => ["Gambling", "DrugsIntoxication", "MatureGame"],
    "is_branded_content" => false
  }

  test "valid get/3" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => @mock})
    end)

    assert Channels.get(broadcaster_ids: [1], token: "token") == {:ok, @mock}
    assert Channels.get(broadcaster_ids: [1], token: "token", client_id: "asdf") == {:ok, @mock}
  end

  test "invalid get/3" do
    Req.Test.stub(Teac.Api, fn conn ->
      Req.Test.json(conn, %{"data" => @mock})
    end)

    assert Channels.get(broadcaster_ids: [], token: "token") ==
             {:error,
              [
                broadcaster_ids:
                  {"should have at least %{count} item(s)",
                   [count: 1, validation: :length, kind: :min, type: :list]}
              ]}

    assert Channels.get(broadcaster_ids: 1..200 |> Enum.to_list(), token: "token") ==
             {:error,
              [
                broadcaster_ids:
                  {"should have at most %{count} item(s)",
                   [count: 100, validation: :length, kind: :max, type: :list]}
              ]}

    assert Channels.get(broadcaster_ids: [1]) ==
             {:error, [token: {"can't be blank", [validation: :required]}]}
  end

  test "patch/1 valid" do
    # fixme
    assert false
  end
end
