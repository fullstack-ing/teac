defmodule Teac.Api.Bits.Cheermotes do
  import Ecto.Changeset
  alias Teac.Api

  @doc """
  Get Cheermotes

  Gets a list of Cheermotes that users can use to cheer Bits in any Bits-enabled channel’s chat room. \
  Cheermotes are animated emotes that viewers can assign Bits to.

  ## Authorization
  Requires an app access token or user access token.

  ## Parameters

  * token : String - required
  * client_id : String - optional
  * broadcaster_id : integer - optional

  Specify the broadcaster’s ID if you want to include the broadcaster’s Cheermotes in the response
  (not all broadcasters upload Cheermotes).

  If not specified, the response contains only global Cheermotes.

  ## Examples

      iex> Teac.Api.Bits.Cheermotes.get(token :token)

      {:ok,[%{
        "prefix" =>  "Cheer",
        "tiers" =>  [
        %{
          "min_bits" =>  1,
          "id" =>  "1",
          "color" =>  "#979797",
          "images" =>  %{
            "dark" =>  %{
              "animated" =>  %{
                "1" =>  "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/dark/animated/1/1.gif",
                ...
              },
              "static" =>  %{
                "1" =>  "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/dark/static/1/1.png",
                ...
              }
            },
            "light" =>  %{
              "animated" =>  %{
                "1" =>  "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/light/animated/1/1.gif",
                ...
              },
              "static" =>  {
                "1" =>  "https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/light/static/1/1.png",
                ...
              }
            }
          },
          "can_cheer" =>  true,
          "show_in_bits_card" =>  true
        }
        },
        "type" =>  "global_first_party",
        "order" =>  1,
        "last_updated" =>  "2018-05-22T00:06:04Z",
        "is_charitable" =>  false
      }],
    }

  """

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id} = args} ->
        params =
          case Map.get(args, :broadcaster_id) do
            nil -> []
            broadcaster_id -> [broadcaster_id: broadcaster_id |> to_string()]
          end

        [
          base_url: Api.uri("bits/cheermotes"),
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
    data = %{}
    types = %{token: :string, client_id: :string, broadcaster_id: :integer}

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id])

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end
end
