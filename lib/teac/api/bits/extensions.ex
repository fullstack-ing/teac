defmodule Teac.Api.Bits.Extensions do
  alias Teac.Api
  import Ecto.Changeset

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id, should_include_all: should_include_all}} ->
        [
          base_url: Api.uri("bits/extensions"),
          params: [should_include_all: should_include_all],
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
      should_include_all: :boolean
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> default_should_include_all()
      |> validate_required([:token, :client_id, :should_include_all])

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  defp default_should_include_all(%{changes: changes} = cs) do
    case Map.get(changes, :should_include_all) do
      nil ->
        put_change(cs, :should_include_all, false)

      _ ->
        cs
    end
  end

  def put(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    case Req.put!(Teac.api_uri() <> "bits/extensions",
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
