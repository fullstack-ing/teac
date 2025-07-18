defmodule Teac.Api.Whipsers do
  alias Teac.Api
  import Ecto.Changeset

  def post(opts) do
    case validate_get_opts(opts) do
      {:ok,
       %{
         token: token,
         client_id: client_id,
         from_user_id: from_user_id,
         to_user_id: to_user_id,
         message: message
       }} ->
        [
          base_url: Api.uri("whispers"),
          params: [from_user_id: from_user_id, to_user_id: to_user_id],
          headers: Api.headers(token, client_id),
          json: %{message: message}
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.post!()
        |> Api.handle_response()

      error ->
        error
    end
  end

  defp validate_get_opts(opt) do
    types = %{
      token: :string,
      client_id: :string,
      from_user_id: :string,
      to_user_id: :string,
      message: :string
    }

    changeset =
      {%{}, types}
      |> cast(Map.new(opt), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :from_user_id, :to_user_id, :message])
      |> validate_length(:message, max: 10_000)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end
end
