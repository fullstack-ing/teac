defmodule Teac.Api.Bits.LeaderboardTest do
  use ExUnit.Case
  doctest Teac

  test "gets Leaderboard for user access_token" do
    {:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()

    {:ok, users} = Teac.MockApi.users()

    %{"id" => user_id} =
      Enum.find(users, fn %{"broadcaster_type" => bt} -> bt == "affiliate" end)

    {:ok, %{"access_token" => access_token}} =
      Teac.MockAuth.fetch_user_access_token(
        client_id: client_id,
        client_secret: client_secret,
        user_id: user_id,
        scope: "bits:read"
      )

    opts = [token: access_token, client_id: client_id, client_secret: client_secret]
    {:ok, data} = Teac.Api.Bits.Leaderboard.get(opts)
    assert is_list(data)

    Enum.each(data, fn item ->
      assert is_map(item)
      assert_has_keys(item, ["rank", "score", "user_id", "user_login", "user_name"])
    end)
  end

  defp assert_has_keys(map, keys) do
    Enum.each(keys, fn key ->
      assert Map.has_key?(map, key)
    end)
  end
end
