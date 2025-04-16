defmodule Teac.Scopes.Channel do
  @moduledoc "Channel management scopes"
  @bot "channel:bot"
  @manage_ads "channel:manage:ads"
  @read_ads "channel:read:ads"
  @manage_broadcast "channel:manage:broadcast"
  @read_charity "channel:read:charity"
  @edit_commercial "channel:edit:commercial"
  @read_editors "channel:read:editors"
  @manage_extensions "channel:manage:extensions"
  @read_goals "channel:read:goals"
  @read_guest_star "channel:read:guest_star"
  @manage_guest_star "channel:manage:guest_star"
  @read_hype_train "channel:read:hype_train"
  @manage_moderators "channel:manage:moderators"
  @read_polls "channel:read:polls"
  @manage_polls "channel:manage:polls"
  @read_predictions "channel:read:predictions"
  @manage_predictions "channel:manage:predictions"
  @manage_raids "channel:manage:raids"
  @read_redemptions "channel:read:redemptions"
  @manage_redemptions "channel:manage:redemptions"
  @manage_schedule "channel:manage:schedule"
  @read_stream_key "channel:read:stream_key"
  @read_subscriptions "channel:read:subscriptions"
  @manage_videos "channel:manage:videos"
  @read_vips "channel:read:vips"
  @manage_vip "channel:manage:vips"
  @moderate "channel:moderate"
  @scope_map %{
    channel_bot: @bot,
    channel_manage_ads: @manage_ads,
    channel_read_ads: @read_ads,
    channel_manage_broadcast: @manage_broadcast,
    channel_read_charity: @read_charity,
    channel_edit_commercial: @edit_commercial,
    channel_read_editors: @read_editors,
    channel_manage_extensions: @manage_extensions,
    channel_read_goals: @read_goals,
    channel_read_guest_star: @read_guest_star,
    channel_manage_guest_star: @manage_guest_star,
    channel_read_hype_train: @read_hype_train,
    channel_manage_moderators: @manage_moderators,
    channel_read_polls: @read_polls,
    channel_manage_polls: @manage_polls,
    channel_read_predictions: @read_predictions,
    channel_manage_predictions: @manage_predictions,
    channel_manage_raids: @manage_raids,
    channel_read_redemptions: @read_redemptions,
    channel_manage_redemptions: @manage_redemptions,
    channel_manage_schedule: @manage_schedule,
    channel_read_stream_key: @read_stream_key,
    channel_read_subscriptions: @read_subscriptions,
    channel_manage_videos: @manage_videos,
    channel_read_vips: @read_vips,
    channel_manage_vips: @manage_vip,
    channel_moderate: @moderate
  }
  use Teac.Scopes.Helper

  @doc """
  Joins your channel’s chatroom as a bot user, and perform chat-related actions as that user.

  API:
  - Send Chat Message: https://dev.twitch.tv/docs/api/reference/#send-chat-message

  EventSub:
  - Channel Chat Clear: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear
  - Channel Chat Clear User Messages: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatclear_user_messages
  - Channel Chat Message: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatmessage
  - Channel Chat Message Delete: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatmessage_delete
  - Channel Chat Notification: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchatnotification
  - Channel Chat Settings Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchat_settingsupdate
  """

  def bot, do: @bot

  @doc """
  Manage ads schedule on a channel.

  API:
  - Snooze Next Ad https://dev.twitch.tv/docs/api/reference#snooze-next-ad
  """
  def manage_ads, do: @manage_ads

  @doc """
  Read the ads schedule and details on your channel.

  API:
  - Get Ad Schedule: https://dev.twitch.tv/docs/api/reference#get-ad-schedule

  EventSub:
  - Channel Ad Break Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelad_breakbegin
  """
  def read_ads, do: @read_ads

  @doc """
  Manage a channel’s broadcast configuration, including updating channel configuration and managing stream markers and stream tags.

  API:
  - Modify Channel Information: https://dev.twitch.tv/docs/api/reference#modify-channel-information
  - Create Stream Marker: https://dev.twitch.tv/docs/api/reference#create-stream-marker
  - Replace Stream Tags: https://dev.twitch.tv/docs/api/reference#replace-stream-tags
  """
  def manage_broadcast, do: @manage_broadcast

  @doc """
  Read charity campaign details and user donations on your channel.

  API:
  - Get Charity Campaign: https://dev.twitch.tv/docs/api/reference#get-charity-campaign
  - Get Charity Campaign Donations: https://dev.twitch.tv/docs/api/reference/#get-charity-campaign-donations

  EventSub
  - Charity Donation: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelcharity_campaigndonate
  - Charity Campaign Start: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelcharity_campaignstart
  - Charity Campaign Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelcharity_campaignprogress
  - Charity Campaign Stop: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelcharity_campaignstop
  """
  def read_charity, do: @read_charity

  @doc """
  Run commercials on a channel.

  API
  - Start Commercial: https://dev.twitch.tv/docs/api/reference#start-commercial
  """
  def edit_commercial, do: @edit_commercial

  @doc """
  View a list of users with the editor role for a channel.

  API:
  - Get Channel Editors: https://dev.twitch.tv/docs/api/reference#get-channel-editors
  """
  def read_editors, do: @read_editors

  @doc """
  Manage a channel’s Extension configuration, including activating Extensions.

  API:
  - Get User Active Extensions: https://dev.twitch.tv/docs/api/reference#get-user-active-extensions
  - Update User Extensions: https://dev.twitch.tv/docs/api/reference#update-user-extensions
  """
  def manage_extensions, do: @manage_extensions

  @doc """
  View Creator Goals for a channel.

  API:
  - Get Creator Goals: https://dev.twitch.tv/docs/api/reference#get-creator-goals

  EventSub:
  - Goal Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelgoalbegin
  - Goal Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelgoalprogress
  - Goal End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelgoalend
  """
  def read_goals, do: @read_goals

  @doc """
  Read Guest Star details for your channel.

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
  Manage Guest Star for your channel.

  API:
  - Update Channel Guest Star Settings: https://dev.twitch.tv/docs/api/reference#update-channel-guest-star-settings
  - Create Guest Star Session: https://dev.twitch.tv/docs/api/reference#create-guest-star-session
  - End Guest Star Session: https://dev.twitch.tv/docs/api/reference#end-guest-star-session
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
  View Hype Train information for a channel.

  API:
  - Get Hype Train Events: https://dev.twitch.tv/docs/api/reference#get-hype-train-events

  EventSub:
  - Hype Train Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelhype_trainbegin
  - Hype Train Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelhype_trainprogress
  - Hype Train End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelhype_trainend
  """
  def read_hype_train, do: @read_hype_train

  @doc """
  Add or remove the moderator role from users in your channel.

  API:
  - Add Channel Moderator: https://dev.twitch.tv/docs/api/reference#add-channel-moderator
  - Remove Channel Moderator: https://dev.twitch.tv/docs/api/reference#remove-channel-moderator
  - Get Moderators: https://dev.twitch.tv/docs/api/reference/#get-moderators
  """
  def manage_moderators, do: @manage_moderators

  @doc """
  View a channel’s polls.

  API:
  - Get Polls: https://dev.twitch.tv/docs/api/reference#get-polls

  EventSub:
  - Channel Poll Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpollbegin
  - Channel Poll Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpollprogress
  - Channel Poll End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpollend
  """
  def read_polls, do: @read_polls

  @doc """
  Manage a channel’s polls.

  API:
  - Get Polls: https://dev.twitch.tv/docs/api/reference#get-polls
  - Create Poll: https://dev.twitch.tv/docs/api/reference#create-poll
  - End Poll: https://dev.twitch.tv/docs/api/reference#end-poll

  EventSub:
  - Channel Poll Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpollbegin
  - Channel Poll Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpollprogress
  - Channel Poll End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpollend
  """
  def manage_polls, do: @manage_polls

  @doc """
  View a channel’s Channel Points Predictions.

  API:
  - Get Channel Points Predictions: https://dev.twitch.tv/docs/api/reference#get-predictions

  EventSub:
  - Channel Prediction Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionbegin
  - Channel Prediction Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionprogress
  - Channel Prediction Lock: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionlock
  - Channel Prediction End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionend
  """
  def read_predictions, do: @read_predictions

  @doc """
  Manage of channel’s Channel Points Predictions

  API:
  - Get Channel Points Predictions: https://dev.twitch.tv/docs/api/reference#get-predictions
  - Create Channel Points Prediction: https://dev.twitch.tv/docs/api/reference#create-prediction
  - End Channel Points Prediction: https://dev.twitch.tv/docs/api/reference#end-prediction

  EventSub:
  - Channel Prediction Begin: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionbegin
  - Channel Prediction Progress: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionprogress
  - Channel Prediction Lock: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionlock
  - Channel Prediction End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelpredictionend
  """
  def manage_predictions, do: @manage_predictions

  @doc """
  Manage a channel raiding another channel.

  API:
  - Start a raid: https://dev.twitch.tv/docs/api/reference#start-a-raid
  - Cancel a raid: https://dev.twitch.tv/docs/api/reference#cancel-a-raid
  """
  def manage_raids, do: @manage_raids

  @doc """
  View Channel Points custom rewards and their redemptions on a channel.

  API:
  - Get Custom Reward: https://dev.twitch.tv/docs/api/reference#get-custom-reward
  - Get Custom Reward Redemption: https://dev.twitch.tv/docs/api/reference#get-custom-reward-redemption

  EventSub:
  - Channel Points Automatic Reward Redemption: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_automatic_reward_redemptionadd
  - Channel Points Automatic Reward Redemption v2: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_automatic_reward_redemptionadd-v2
  - Channel Points Custom Reward Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_rewardadd
  - Channel Points Custom Reward Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_rewardupdate
  - Channel Points Custom Reward Remove: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_rewardremove
  - Channel Points Custom Reward Redemption Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_reward_redemptionadd
  - Channel Points Custom Reward Redemption Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_reward_redemptionupdate
  """
  def read_redemptions, do: @read_redemptions

  @doc """
  Manage Channel Points custom rewards and their redemptions on a channel.

  API:
  - Get Custom Reward: https://dev.twitch.tv/docs/api/reference#get-custom-reward
  - Get Custom Reward Redemption: https://dev.twitch.tv/docs/api/reference#get-custom-reward-redemption
  - Create Custom Rewards: https://dev.twitch.tv/docs/api/reference#create-custom-rewards
  - Delete Custom Reward: https://dev.twitch.tv/docs/api/reference#delete-custom-reward
  - Update Custom Reward: https://dev.twitch.tv/docs/api/reference#update-custom-reward
  - Update Redemption Status: https://dev.twitch.tv/docs/api/reference#update-redemption-status

  EventSub:
  - Channel Points Automatic Reward Redemption: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_automatic_reward_redemptionadd
  - Channel Points Custom Reward Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_rewardadd
  - Channel Points Custom Reward Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_rewardupdate
  - Channel Points Custom Reward Remove: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_rewardremove
  - Channel Points Custom Reward Redemption Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_reward_redemptionadd
  - Channel Points Custom Reward Redemption Update: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelchannel_points_custom_reward_redemptionupdate
  """
  def manage_redemptions, do: @manage_redemptions

  @doc """
  Manage a channel’s stream schedule.

  API:
  - Update Channel Stream Schedule: https://dev.twitch.tv/docs/api/reference#update-channel-stream-schedule
  - Create Channel Stream Schedule Segment: https://dev.twitch.tv/docs/api/reference#create-channel-stream-schedule-segment
  - Update Channel Stream Schedule Segment: https://dev.twitch.tv/docs/api/reference#update-channel-stream-schedule-segment
  - Delete Channel Stream Schedule Segment: https://dev.twitch.tv/docs/api/reference#delete-channel-stream-schedule-segment
  """
  def manage_schedule, do: @manage_schedule

  @doc """
  View an authorized user’s stream key.

  API:
  - Get Stream Key: https://dev.twitch.tv/docs/api/reference#get-stream-key
  """
  def read_stream_key, do: @read_stream_key

  @doc """
  View a list of all subscribers to a channel and check if a user is subscribed to a channel.

  API:
  - Get Broadcaster Subscriptions: https://dev.twitch.tv/docs/api/reference#get-broadcaster-subscriptions

  EventSub:
  - Channel Subscribe: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelsubscribe
  - Channel Subscription End: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelsubscriptionend
  - Channel Subscription Gift: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelsubscriptiongift
  - Channel Subscription Message: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelsubscriptionmessage
  """
  def read_subscriptions, do: @read_subscriptions

  @doc """
  Manage a channel’s videos, including deleting videos.

  API:
  - Delete Videos: https://dev.twitch.tv/docs/api/reference#delete-videos
  """
  def manage_videos, do: @manage_videos

  @doc """
  Read the list of VIPs in your channel.

  API:
  - Get VIPs: https://dev.twitch.tv/docs/api/reference#get-vips

  EventSub:
  - Channel VIP Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelvipadd
  - Channel VIP Remove: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelvipremove
  """
  def read_vips, do: @read_vips

  @doc """
  Add or remove the VIP role from users in your channel.

  API:
  - Get VIPs: https://dev.twitch.tv/docs/api/reference#get-vips
  - Add Channel VIP: https://dev.twitch.tv/docs/api/reference#add-channel-vip
  - Remove Channel VIP: https://dev.twitch.tv/docs/api/reference#remove-channel-vip

  EventSub:
  - Channel VIP Add: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelvipadd
  - Channel VIP Remove: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelvipremove
  """
  def manage_vip, do: @manage_vip

  @doc """
  Perform moderation actions in a channel.

  EventSub:
  - Channel Ban: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelban
  - Channel Unban: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelunban
  """
  def moderate, do: @moderate
end
