defmodule Api.ChannelPoints.CustomRewardsTest do
  use ExUnit.Case
  doctest Teac

  test "gets CustomRewards for user access_token" do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()

    {:ok, users} = Teac.MockApi.users()

    %{"id" => user_id} =
      Enum.find(users, fn %{"broadcaster_type" => bt} -> bt == "affiliate" end)

    {:ok, %{"access_token" => access_token}} =
      Teac.MockAuth.fetch_user_access_token(
        client_id: client_id,
        client_secret: client_secret,
        user_id: user_id,
        scope: "channel:manage:redemptions"
      )

    opts = [
      token: access_token,
      client_id: client_id,
      client_secret: client_secret,
      broadcaster_id: user_id
    ]

    {:ok, data} = Teac.Api.ChannelPoints.CustomRewards.get(opts)
    assert is_list(data)

    Enum.each(data, fn item ->
      assert is_map(item)

      assert_has_keys(item, [
        "title",
        "should_redemptions_skip_request_queue",
        "redemptions_redeemed_current_stream",
        "prompt",
        "is_user_input_required",
        "is_paused",
        "is_in_stock",
        "is_enabled",
        "image",
        "background_color",
        "broadcaster_id",
        "broadcaster_login",
        "broadcaster_name",
        "cooldown_expires_at",
        "cost"
      ])

      default_image = item["default_image"]
      assert is_map(default_image)
      assert_has_keys(default_image, ["url_1x", "url_2x", "url_4x"])

      max_per_user_per_stream_setting = item["max_per_user_per_stream_setting"]
      assert is_map(max_per_user_per_stream_setting)
      assert_has_keys(max_per_user_per_stream_setting, ["is_enabled", "max_per_user_per_stream"])
    end)
  end

  defp assert_has_keys(map, keys) do
    Enum.each(keys, fn key ->
      assert Map.has_key?(map, key)
    end)
  end
end
