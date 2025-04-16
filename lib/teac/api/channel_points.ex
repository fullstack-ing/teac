defmodule Teac.Api.ChannelPoints do
  defmodule CustomRewards do
    @doc """
    https://dev.twitch.tv/docs/api/reference/#get-custom-reward
    """
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      params = [
        broadcaster_id: Keyword.fetch!(opts, :broadcaster_id),
        only_manageable_rewards: Keyword.get(opts, :only_manageable_rewards, false)
      ]

      params =
        case Keyword.take(opts, [:id]) do
          [] -> params
          ids -> params ++ ids
        end

      case Req.get!(Teac.Api.api_uri() <> "channel_points/custom_rewards",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: params
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.post!(Teac.Api.api_uri() <> "channel_points/custom_rewards",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             params: [broadcaster_id: Keyword.fetch!(opts, :broadcaster_id)],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def patch(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.patch!(Teac.Api.api_uri() <> "channel_points/custom_rewards",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def delete(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.delete!(Teac.Api.api_uri() <> "channel_points/custom_rewards",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Redemptions do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      params =
        case Keyword.get(opts, :broadcaster_id) do
          nil -> []
          broadcaster_id -> [broadcaster_id: broadcaster_id]
        end

      params =
        case Keyword.get(opts, :status) do
          nil -> params
          status -> params ++ [status: status]
        end

      params =
        case Keyword.get(opts, :reward_id) do
          nil -> params
          reward_id -> params ++ [reward_id: reward_id]
        end

      ids = opts |> Keyword.get(:ids, []) |> List.wrap() |> Enum.map(&to_string/1)
      total = length(ids)

      cond do
        total > 100 ->
          {:error, "Total IDs and or Names and or IGDB IDs cannot exceed 100"}

        true ->
          # Convert to repeated query params
          params =
            (Enum.map(ids, &{:id, &1}) ++ params)
            |> dbg()

          case Req.get!(Teac.Api.api_uri() <> "channel_points/custom_rewards/redemptions",
                 headers: [
                   {"Authorization", "Bearer #{token}"},
                   {"Client-Id", client_id}
                 ],
                 params: params
               ) do
            %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
            %Req.Response{body: body} -> {:error, body}
          end
      end
    end

    def patch(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.patch!(
             Teac.Api.api_uri() <> "channel_points/custom_rewards/redemptions",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end
end
