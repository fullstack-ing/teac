defmodule Teac.Api.ChannelPoints.Redemptions do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

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
          Enum.map(ids, &{:id, &1}) ++ params

        case Req.get!(Teac.api_uri() <> "channel_points/custom_rewards/redemptions",
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
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    case Req.patch!(
           Teac.api_uri() <> "channel_points/custom_rewards/redemptions",
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
