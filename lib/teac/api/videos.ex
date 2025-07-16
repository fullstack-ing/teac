defmodule Teac.Api.Videos do
  alias Teac.Api
  import Ecto.Changeset

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok,
       %{token: token, client_id: client_id, ids: ids, user_id: user_id, game_id: game_id} = args} ->
        params =
          ids
          |> Enum.map(&to_string/1)
          |> Enum.map(&{:id, &1})
          |> Keyword.merge(
            user_id: user_id,
            game_id: game_id,
            language: Map.get(args, :language, nil),
            period: Map.get(args, :period, nil),
            sort: Map.get(args, :sort, nil),
            type: Map.get(args, :v, nil),
            first: Map.get(args, :first, nil),
            after: Map.get(args, :after, nil),
            before: Map.get(args, :before, nil)
          )
          |> Keyword.filter(fn {_, v} -> v != nil end)

        [
          base_url: Api.uri("videos"),
          params: params,
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.get!()
        |> Api.handle_response()

      error ->
        error
    end
  end

  defp validate_get_opts(opt) do
    types = %{
      ids: {:array, :string},
      user_id: :string,
      game_id: :string,
      language: :string,
      period: :string,
      sort: :string,
      type: :string,
      first: :integer,
      after: :string,
      before: :string,
      token: :string,
      client_id: :string
    }

    changeset =
      {%{}, types}
      |> cast(Map.new(opt), Map.keys(types))
      |> Api.default_client_id()
      |> validate_inclusion(:period, ["all", "day", "week", "month"])
      |> validate_inclusion(:sort, ["time", "trending", "views"])
      |> validate_inclusion(:type, ["all", "archive", "highlight", "upload"])
      |> validate_number(:first, greater_than: 0, less_than: 101)
      |> validate_required([:token, :client_id, :ids, :user_id, :game_id])

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  def delete(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    id = Keyword.fetch!(opts, :id)

    case Req.delete!(Teac.api_uri() <> "videos",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           params: [id: id]
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
