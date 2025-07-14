defmodule Teac.Api.Bits do
  @moduledoc false
  import Ecto.Changeset
  alias Teac.Api

  defmodule Leaderboard do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      params = []

      params =
        case Keyword.get(opts, :count) do
          nil -> params
          count -> params ++ [count: count]
        end

      params =
        case Keyword.get(opts, :period) do
          nil ->
            params

          period ->
            if period in ["day", "week", "month", "year", "all"] do
              params ++ [period: period]
            else
              period
            end
        end

      params =
        case Keyword.get(opts, :started_at) do
          nil -> params
          started_at -> params ++ [started_at: started_at]
        end

      params =
        case Keyword.get(opts, :user_id) do
          nil -> params
          user_id -> params ++ [user_id: user_id]
        end

      case Req.get!(Teac.api_uri() <> "bits/leaderboard",
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

  defmodule Cheermotes do
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
              broadcaster_id -> [broadcaster_id: broadcaster_id]
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

  defmodule Extensions do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "bits/extensions",
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
end
