defmodule Teac.Api.Bits.CheermotesTest do
  use ExUnit.Case
  doctest Teac

  test "gets Cheermotes for app access_token" do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()

    {:ok, %{"access_token" => access_token}} =
      Teac.MockAuth.fetch_app_access_token(client_id: client_id, client_secret: client_secret)

    opts = [token: access_token, client_id: client_id, client_secret: client_secret]
    {:ok, data} = Teac.Api.Bits.Cheermotes.get(opts)
    assert is_list(data)

    Enum.each(data, fn item ->
      assert is_map(item)
      assert_has_keys(item, ["is_charitable", "last_updated", "order", "prefix", "tiers", "type"])

      tiers = item["tiers"]
      assert is_list(tiers)

      Enum.each(tiers, fn tier ->
        assert is_map(tier)

        assert_has_keys(tier, [
          "can_cheer",
          "color",
          "id",
          "images",
          "min_bits",
          "show_in_bits_card"
        ])

        images = tier["images"]
        assert is_map(images)
        assert_has_keys(images, ["dark", "light"])

        Enum.each(["dark", "light"], fn theme_key ->
          theme = images[theme_key]
          assert is_map(theme)
          assert_has_keys(theme, ["animated", "static"])

          Enum.each(["animated", "static"], fn type_key ->
            type_map = theme[type_key]
            assert is_map(type_map)
            assert_has_keys(type_map, ["1", "1.5", "2", "3", "4"])
          end)
        end)
      end)
    end)
  end

  test "gets Cheermotes for user access_token" do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()

    {:ok, users} = Teac.MockApi.users()

    %{"id" => user_id} =
      Enum.find(users, fn %{"broadcaster_type" => bt} -> bt == "affiliate" end)

    {:ok, %{"access_token" => access_token}} =
      Teac.MockAuth.fetch_user_access_token(
        client_id: client_id,
        client_secret: client_secret,
        user_id: user_id,
        scope: nil
      )

    opts = [token: access_token, client_id: client_id, client_secret: client_secret]
    {:ok, data} = Teac.Api.Bits.Cheermotes.get(opts)
    assert is_list(data)

    Enum.each(data, fn item ->
      assert is_map(item)
      assert_has_keys(item, ["is_charitable", "last_updated", "order", "prefix", "tiers", "type"])

      tiers = item["tiers"]
      assert is_list(tiers)

      Enum.each(tiers, fn tier ->
        assert is_map(tier)

        assert_has_keys(tier, [
          "can_cheer",
          "color",
          "id",
          "images",
          "min_bits",
          "show_in_bits_card"
        ])

        images = tier["images"]
        assert is_map(images)
        assert_has_keys(images, ["dark", "light"])

        Enum.each(["dark", "light"], fn theme_key ->
          theme = images[theme_key]
          assert is_map(theme)
          assert_has_keys(theme, ["animated", "static"])

          Enum.each(["animated", "static"], fn type_key ->
            type_map = theme[type_key]
            assert is_map(type_map)
            assert_has_keys(type_map, ["1", "1.5", "2", "3", "4"])
          end)
        end)
      end)
    end)
  end

  defp assert_has_keys(map, keys) do
    Enum.each(keys, fn key ->
      assert Map.has_key?(map, key)
    end)
  end
end
