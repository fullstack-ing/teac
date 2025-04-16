defmodule Teac.Scopes.Moderation do
  @moduledoc "Moderation scopes"
  @read "moderation:read"
  @manage_announcements "moderator:manage:announcements"
  @manage_automod "moderator:manage:automod"
  @read_automod_settings "moderator:read:automod_settings"
  @manage_automod_settings "moderator:manage:automod_settings"
  @read_banned_users "moderator:read:banned_users"
  @manage_banned_users "moderator:manage:banned_users"
  @read_blocked_terms "moderator:read:blocked_terms"
  @read_chat_messages "moderator:read:chat_messages"
  @manage_blocked_terms "moderator:manage:blocked_terms"
  @manage_chat_messages "moderator:manage:chat_messages"
  @read_chat_settings "moderator:read:chat_settings"
  @manage_chat_settings "moderator:manage:chat_settings"
  @read_chatters "moderator:read:chatters"
  @read_followers "moderator:read:followers"
  @read_guest_star "moderator:read:guest_star"
  @manage_guest_star "moderator:manage:guest_star"
  @read_moderators "moderator:read:moderators"
  @read_shield_mode "moderator:read:shield_mode"
  @manage_shield_mode "moderator:manage:shield_mode"
  @read_shoutouts "moderator:read:shoutouts"
  @manage_shoutouts "moderator:manage:shoutouts"
  @read_suspicious_users "moderator:read:suspicious_users"
  @read_unban_requests "moderator:read:unban_requests"
  @manage_unban_requests "moderator:manage:unban_requests"
  @read_vips "moderator:read:vips"
  @read_warnings "moderator:read:warnings"
  @manage_warnings "moderator:manage:warnings"
  @scope_map %{
    moderation_read: @read,
    moderator_manage_announcements: @manage_announcements,
    moderator_manage_automod: @manage_automod,
    moderator_read_automod_settings: @read_automod_settings,
    moderator_manage_automod_settings: @manage_automod_settings,
    moderator_read_banned_users: @read_banned_users,
    moderator_manage_banned_users: @manage_banned_users,
    moderator_read_blocked_terms: @read_blocked_terms,
    moderator_read_chat_messages: @read_chat_messages,
    moderator_manage_blocked_terms: @manage_blocked_terms,
    moderator_manage_chat_messages: @manage_chat_messages,
    moderator_read_chat_settings: @read_chat_settings,
    moderator_manage_chat_settings: @manage_chat_messages,
    moderator_read_chatters: @read_chatters,
    moderator_read_followers: @read_followers,
    moderator_read_guest_star: @read_guest_star,
    moderator_manage_guest_star: @manage_guest_star,
    moderator_read_moderators: @read_moderators,
    moderator_read_shield_mode: @read_shield_mode,
    moderator_manage_shield_mode: @manage_shield_mode,
    moderator_read_shoutouts: @read_shoutouts,
    moderator_manage_shoutouts: @manage_shoutouts,
    moderator_read_suspicious_users: @read_suspicious_users,
    moderator_read_unban_requests: @read_unban_requests,
    moderator_manage_unban_requests: @manage_unban_requests,
    moderator_read_vips: @read_vips,
    moderator_read_warnings: @read_warnings,
    moderator_manage_warnings: @manage_warnings
  }
  use Teac.Scopes.Helper

  @doc """
  View a channel’s moderation data including Moderators, Bans, Timeouts, and Automod settings.

  API:
  - Check AutoMod Status: https://dev.twitch.tv/docs/api/reference#check-automod-status
  - Get Banned Users: https://dev.twitch.tv/docs/api/reference#get-banned-users
  - Get Moderators: https://dev.twitch.tv/docs/api/reference#get-moderators

  EventSub:
  - Channel Moderator Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderatoradd
  - Channel Moderator Remove: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderatorremove
  """
  def read, do: @read

  @doc """
  Send announcements in channels where you have the moderator role.

  API:
  - Send Chat Announcement: https://dev.twitch.tv/docs/api/reference#send-chat-announcement
  """
  def manage_announcements, do: @manage_announcements

  @doc """
  Manage messages held for review by AutoMod in channels where you are a moderator.

  API:
  - Manage Held AutoMod Messages: https://dev.twitch.tv/docs/api/reference#manage-held-automod-messages

  EventSub:
  - AutoMod Message Hold: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#automodmessagehold
  - AutoMod Message Hold v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#automodmessagehold-v2
  - AutoMod Message Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#automodmessageupdate
  - AutoMod Message Update v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#automodmessageupdate-v2
  - AutoMod Terms Update: https://dev.twitch.tv/docs/authentication/eventsub/eventsub-subscription-types/#automodtermsupdate
  """
  def manage_automod, do: @manage_automod

  @doc """
  View a broadcaster’s AutoMod settings.

  API:
  - Get AutoMod Settings: https://dev.twitch.tv/docs/api/reference#get-automod-settings

  EventSub:
  - AutoMod Settings Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#automodsettingsupdate
  """
  def read_automod_settings, do: @read_automod_settings

  @doc """
  Manage a broadcaster’s AutoMod settings.

  API:
  - Update AutoMod Settings: https://dev.twitch.tv/docs/api/reference#update-automod-settings
  """
  def manage_automod_settings, do: @manage_automod_settings

  @doc """
  Read the list of bans or unbans in channels where you have the moderator role.

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  - Channel Moderate v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate-v2
  """
  def read_banned_users, do: @read_banned_users

  @doc """
  Ban and unban users.

  API:
  - Get Banned Users: https://dev.twitch.tv/docs/api/reference/#get-banned-users
  - Ban User: https://dev.twitch.tv/docs/api/reference#ban-user
  - Unban User: https://dev.twitch.tv/docs/api/reference#unban-user

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  - Channel Moderate v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate-v2
  """
  def manage_banned_users, do: @manage_banned_users

  @doc """
  View a broadcaster’s list of blocked terms.

  API:
  - Get Blocked Terms: https://dev.twitch.tv/docs/api/reference#get-blocked-terms

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def read_blocked_terms, do: @read_blocked_terms

  @doc """
  Read deleted chat messages in channels where you have the moderator role.

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def read_chat_messages, do: @read_chat_messages

  @doc """
  Manage a broadcaster’s list of blocked terms.

  API:
  - Get Blocked Terms: https://dev.twitch.tv/docs/api/reference#get-blocked-terms
  - Add Blocked Term: https://dev.twitch.tv/docs/api/reference#add-blocked-term
  - Remove Blocked Term: https://dev.twitch.tv/docs/api/reference#remove-blocked-term

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def manage_blocked_terms, do: @manage_blocked_terms

  @doc """
  Delete chat messages in channels where you have the moderator role

  API:
  - Delete Chat Messages: https://dev.twitch.tv/docs/api/reference#delete-chat-messages

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def manage_chat_messages, do: @manage_chat_messages

  @doc """
  View a broadcaster’s chat room settings.

  API:
  - Get Chat Settings: https://dev.twitch.tv/docs/api/reference#get-chat-settings

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def read_chat_settings, do: @read_chat_settings

  @doc """
  Manage a broadcaster’s chat room settings.

  API:
  - Update Chat Settings: https://dev.twitch.tv/docs/api/reference#update-chat-settings

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def manage_chat_settings, do: @manage_chat_settings

  @doc """
  View the chatters in a broadcaster’s chat room.

  API:
  - Get Chatters: https://dev.twitch.tv/docs/api/reference#get-chatters
  """
  def read_chatters, do: @read_chatters

  @doc """
  Read the followers of a broadcaster.

  API:
  - Get Channel Followers: https://dev.twitch.tv/docs/api/reference#get-channel-followers

  EventSub:
  - Channel Follow: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelfollow
  """
  def read_followers, do: @read_followers

  @doc """
  Read Guest Star details for channels where you are a Guest Star moderator.

  API:
  - Get Channel Guest Star Settings: https://dev.twitch.tv/docs/api/reference#get-channel-guest-star-settings
  - Get Guest Star Session: https://dev.twitch.tv/docs/api/reference#get-guest-star-session
  - Get Guest Star Invites: https://dev.twitch.tv/docs/api/reference#get-guest-star-invites

  EventSub:
  - Channel Guest Star Session Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_sessionbegin
  - Channel Guest Star Session End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_sessionend
  - Channel Guest Star Guest Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_guestupdate
  - Channel Guest Star Settings Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_settingsupdate
  """
  def read_guest_star, do: @read_guest_star

  @doc """
  Manage Guest Star for channels where you are a Guest Star moderator.

  API:
  - Send Guest Star Invite: https://dev.twitch.tv/docs/api/reference#send-guest-star-invite
  - Delete Guest Star Invite: https://dev.twitch.tv/docs/api/reference#delete-guest-star-invite
  - Assign Guest Star Slot: https://dev.twitch.tv/docs/api/reference#assign-guest-star-slot
  - Update Guest Star Slot: https://dev.twitch.tv/docs/api/reference#update-guest-star-slot
  - Delete Guest Star Slot: https://dev.twitch.tv/docs/api/reference#delete-guest-star-slot
  - Update Guest Star Slot Settings: https://dev.twitch.tv/docs/api/reference#update-guest-star-slot-settings

  EventSub:
  - Channel Guest Star Session Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_sessionbegin
  - Channel Guest Star Session End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_sessionend
  - Channel Guest Star Guest Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_guestupdate
  - Channel Guest Star Settings Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelguest_star_settingsupdate
  """
  def manage_guest_star, do: @manage_guest_star

  @doc """
  Read the list of moderators in channels where you have the moderator role.

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  - Channel Moderate v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate-v2
  """
  def read_moderators, do: @read_moderators

  @doc """
  View a broadcaster’s Shield Mode status.

  API:
  - Get Shield Mode Status: https://dev.twitch.tv/docs/api/reference#update-shield-mode-status

  EventSub:
  - Shield Mode Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshield_modebegin
  - Shield Mode End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshield_modeend
  """
  def read_shield_mode, do: @read_shield_mode

  @doc """
  Manage a broadcaster’s Shield Mode status.

  API:
  - Update Shield Mode Status: https://dev.twitch.tv/docs/api/reference#update-shield-mode-status

  EventSub:
  - Shield Mode Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshield_modebegin
  - Shield Mode End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshield_modeend
  """
  def manage_shield_mode, do: @manage_shield_mode

  @doc """
  View a broadcaster’s shoutouts.

  EventSub:
  - Shoutout Create: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshoutoutcreate
  - Shoutout Received: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshoutoutreceive
  """
  def read_shoutouts, do: @read_shoutouts

  @doc """
  Manage a broadcaster’s shoutouts.

  API:
  - Send a Shoutout: https://dev.twitch.tv/docs/api/reference#send-a-shoutout

  EventSub:
  - Shoutout Create: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshoutoutcreate
  - Shoutout Received: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelshoutoutreceive
  """
  def manage_shoutouts, do: @manage_shoutouts

  @doc """
  Read chat messages from suspicious users and see users flagged as suspicious in channels where you have the moderator role.

  EventSub:
  - Channel Suspicious User Message: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelsuspicious_usermessage
  - Channel Suspicious User Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelsuspicious_userupdate
  """
  def read_suspicious_users, do: @read_suspicious_users

  @doc """
  View a broadcaster’s unban requests.

  API:
  - Get Unban Requests: https://dev.twitch.tv/docs/api/reference/#get-unban-requests

  EventSub:
  - Channel Unban Request Create: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelunban_requestcreate
  - Channel Unban Request Resolve: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelunban_requestresolve
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def read_unban_requests, do: @read_unban_requests

  @doc """
  Manage a broadcaster’s unban requests.

  API:
  - Resolve Unban Requests: https://dev.twitch.tv/docs/api/reference/#resolve-unban-requests

  EventSub:
  - Channel Unban Request Create: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelunban_requestcreate
  - Channel Unban Request Resolve: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelunban_requestresolve
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  """
  def manage_unban_requests, do: @manage_unban_requests

  @doc """
  Read the list of VIPs in channels where you have the moderator role.

  EventSub:
  - Channel Moderate: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate
  - Channel Moderate v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate-v2
  """
  def read_vips, do: @read_vips

  @doc """
  Read warnings in channels where you have the moderator role.

  EventSub:
  - Channel Moderate v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate-v2
  - Channel Warning Acknowledge: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelwarningacknowledge
  - Channel Warning Send: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelwarningsend
  """
  def read_warnings, do: @read_warnings

  @doc """
  Warn users in channels where you have the moderator role.

  API:
  - Warn Chat User: https://dev.twitch.tv/docs/api/reference#warn-chat-user

  EventSub:
  - Channel Moderate v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelmoderate-v2
  - Channel Warning Acknowledge: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelwarningacknowledge
  - Channel Warning Send: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelwarningsend
  """
  def manage_warnings, do: @manage_warnings
end
