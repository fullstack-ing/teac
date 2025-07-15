defmodule Teac.Api.Games do
  alias Teac.Api
  import Ecto.Changeset

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id} = cs} ->
        ids =
          cs
          |> Map.get(:ids, [])
          |> Enum.map(&{:id, &1})

        names =
          cs
          |> Map.get(:names, [])
          |> Enum.map(&{:name, &1})

        igdb_ids =
          cs
          |> Map.get(:igdb_ids, [])
          |> Enum.map(&{:igdb_id, &1})

        [
          base_url: Api.uri("games"),
          params: ids ++ names ++ igdb_ids,
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
    data = %{}

    types = %{
      token: :string,
      client_id: :string,
      ids: {:array, :string},
      names: {:array, :string},
      igdb_ids: {:array, :string}
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id])
      |> validate_includes_at_least_one_param()
      |> validate_limit_on_params()

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  def validate_includes_at_least_one_param(%{changes: changes} = cs) do
    case Map.get(changes, :ids) || Map.get(changes, :names) || Map.get(changes, :igdb_ids) do
      nil ->
        cs
        |> add_error(
          :params,
          "Requires at least one of these params 'ids', 'names' and or 'igdb_ids'"
        )

      _ ->
        cs
    end
  end

  def validate_limit_on_params(%{changes: changes} = cs) do
    ids = Map.get(changes, :ids, []) |> Enum.count()
    names = Map.get(changes, :names, []) |> Enum.count()
    igdbs = Map.get(changes, :igdb_ids, []) |> Enum.count()

    if ids + names + igdbs > 100 do
      cs
      |> add_error(
        :params,
        "Exceeds more than 100 'ids', 'names' and or 'igdb_ids'"
      )
    else
      cs
    end
  end
end
