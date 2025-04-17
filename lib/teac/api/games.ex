defmodule Teac.Api.Games do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    ids = opts |> Keyword.get(:ids, []) |> List.wrap() |> Enum.map(&to_string/1)
    names = opts |> Keyword.get(:names, []) |> List.wrap() |> Enum.map(&to_string/1)
    igdb_id = opts |> Keyword.get(:igdb_ids, []) |> List.wrap() |> Enum.map(&to_string/1)

    total = length(ids) + length(names) + length(igdb_id)

    cond do
      total > 100 ->
        {:error, "Total IDs and or Names and or IGDB IDs cannot exceed 100"}

      true ->
        # Convert to repeated query params
        params =
          Enum.map(ids, &{:id, &1}) ++
            Enum.map(names, &{:name, &1}) ++
            Enum.map(igdb_id, &{:igdb_id, &1})

        case Req.get!(Teac.api_uri() <> "games",
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

  defmodule Top do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "games/top",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: []
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end
end
