defmodule Teac.Scopes.User do
  @moduledoc "User scopes"
  @bot "user:bot"
  @edit "user:edit"
  @edit_broadcast "user:edit:broadcast"
  @read_blocked_users "user:read:blocked_users"
  @manage_blocked_users "user:manage:blocked_users"
  @read_broadcast "user:read:broadcast"
  @read_chat "user:read:chat"
  @manage_chat_color "user:manage:chat_color"
  @read_email "user:read:email"
  @read_emotes "user:read:emotes"
  @read_follows "user:read:follows"
  @read_moderated_channels "user:read:moderated_channels"
  @read_subscriptions "user:read:subscriptions"
  @read_whispers "user:read:whispers"
  @manage_whispers "user:manage:whispers"
  @write_chat "user:write:chat"
  @scope_map %{
    user_bot: @bot,
    user_edit: @edit,
    user_edit_broadcast: @edit_broadcast,
    user_read_blocked_users: @read_blocked_users,
    user_manage_blocked_users: @manage_blocked_users,
    user_read_broadcast: @read_broadcast,
    user_read_chat: @read_chat,
    user_manage_chat_color: @manage_chat_color,
    user_read_email: @read_email,
    user_read_emotes: @read_emotes,
    user_read_follows: @read_follows,
    user_read_moderated_channels: @read_moderated_channels,
    user_read_subscriptions: @read_subscriptions,
    user_read_whispers: @read_whispers,
    user_manage_whispers: @manage_whispers,
    user_write_chat: @write_chat
  }
  use Teac.Scopes.Helper

  @doc """
  Join a specified chat channel as your user and appear as a bot, and perform chat-related actions as your user.

  API:
  - Send Chat Message: https://dev.twitch.tv/docs/api/reference/#send-chat-message

  EventSub:
  - Channel Chat Clear: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear
  - Channel Chat Clear User Messages: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear_user_messages
  - Channel Chat Message: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatmessage
  - Channel Chat Message Delete: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatmessage_delete
  - Channel Chat Notification: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatnotification
  - Channel Chat Settings Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchat_settingsupdate
  - Channel Chat User Message Hold: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchat_user_message_hold
  - Channel Chat User Message Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatuser_message_update
  """
  def bot, do: @bot

  @doc """
  user:edit 	Manage a user object.

  API:
  - Update User: https://dev.twitch.tv/docs/api/reference#update-user
  """
  def edit, do: @edit

  @doc """
  View and edit a user’s broadcasting configuration, including Extension configurations.

  API:
  - Get User Extensions: https://dev.twitch.tv/docs/api/reference/#get-user-extensions
  - Get User Active Extensions: https://dev.twitch.tv/docs/api/reference/#get-user-active-extensions
  - Update User Extensions: https://dev.twitch.tv/docs/api/reference/#update-user-extensions
  """
  def edit_broadcast, do: @edit_broadcast

  @doc """
  View the block list of a user.

  API:
  - Get User Block List: https://dev.twitch.tv/docs/api/reference#get-user-block-list
  """
  def read_blocked_users, do: @read_blocked_users

  @doc """
  Manage the block list of a user.

  API:
  - Block User: https://dev.twitch.tv/docs/api/reference#block-user
  - Unblock User: https://dev.twitch.tv/docs/api/reference#unblock-user
  """
  def manage_blocked_users, do: @manage_blocked_users

  @doc """
  View a user’s broadcasting configuration, including Extension configurations.

  API:
  - Get Stream Markers: https://dev.twitch.tv/docs/api/reference#get-stream-markers
  - Get User Extensions: https://dev.twitch.tv/docs/api/reference#get-user-extensions
  - Get User Active Extensions: https://dev.twitch.tv/docs/api/reference#get-user-active-extensions
  """
  def read_broadcast, do: @read_broadcast

  @doc """
  Receive chatroom messages and informational notifications relating to a channel’s chatroom.

  EventSub:
  - Channel Chat Clear: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear
  - Channel Chat Clear User Messages: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear_user_messages
  - Channel Chat Message: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear_user_messages
  - Channel Chat Message Delete: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatmessage_delete
  - Channel Chat Notification: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatnotification
  - Channel Chat Settings Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchat_settingsupdate
  - Channel Chat User Message Hold: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatuser_message_hold
  - Channel Chat User Message Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatuser_message_update

  """
  def read_chat, do: @read_chat

  @doc """
  Update the color used for the user’s name in chat.

  API:
  - Update User Chat Color: https://dev.twitch.tv/docs/api/reference#update-user-chat-color
  """
  def manage_chat_color, do: @manage_chat_color

  @doc """
  View a user’s email address.

  API:
  - Get Users (optional): https://dev.twitch.tv/docs/api/reference#get-users
  - Update User (optional): https://dev.twitch.tv/docs/api/reference/#update-user

  EventSub:
  - User Update (optional): https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#userupdate
  """
  def read_email, do: @read_email

  @doc """
  View emotes available to a user

  API:
  - Get User Emotes: https://dev.twitch.tv/docs/api/reference/#get-user-emotes
  """
  def read_emotes, do: @read_emotes

  @doc """
  View the list of channels a user follows.

  API:
  - Get Followed Channels: https://dev.twitch.tv/docs/api/reference#get-followed-channels
  - Get Followed Streams: https://dev.twitch.tv/docs/api/reference#get-followed-streams
  """
  def read_follows, do: @read_follows

  @doc """
  Read the list of channels you have moderator privileges in.

  API:
  - Get Moderated Channels: https://dev.twitch.tv/docs/api/reference#get-moderated-channels
  """
  def read_moderated_channels, do: @read_moderated_channels

  @doc """
  View if an authorized user is subscribed to specific channels.

  API:
  - Check User Subscription: https://dev.twitch.tv/docs/api/reference#check-user-subscription
  """
  def read_subscriptions, do: @read_subscriptions

  @doc """
  Receive whispers sent to your user.

  EventSub:
  - Whisper Received: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#userwhispermessage
  """
  def read_whispers, do: @read_whispers

  @doc """
  Receive whispers sent to your user, and send whispers on your user’s behalf.

  API:
  - Send Whisper: https://dev.twitch.tv/docs/api/reference#send-whisper

  EventSub:
  - Whisper Received: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#userwhispermessage
  """
  def manage_whispers, do: @manage_whispers

  @doc """
  Send chat messages to a chatroom.

  API:
  - Send Chat Message: https://dev.twitch.tv/docs/api/reference/#send-chat-message
  """
  def write_chat, do: @write_chat
end
