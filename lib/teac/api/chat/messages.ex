defmodule Teac.Api.Chat.Messages do
  def post(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    message = Keyword.fetch!(opts, :message)
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)
    sender_id = Keyword.fetch!(opts, :sender_id)
    reply_parent_message_id = Keyword.get(opts, :reply_parent_message_id)

    case Req.post!(Teac.api_uri() <> "chat/messages",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           form: [
             message: message,
             broadcaster_id: broadcaster_id,
             sender_id: sender_id,
             reply_parent_message_id: reply_parent_message_id
           ],
           decode_body: :json
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
