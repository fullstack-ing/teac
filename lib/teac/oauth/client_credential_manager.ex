defmodule Teac.Oauth.ClientCredentialManager do
  use GenServer

  # Client API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_token do
    GenServer.call(__MODULE__, :get_token)
  end

  # Server Callbacks
  @impl true
  def init(_state) do
    # Schedule initial token fetch immediately
    Process.send_after(self(), :refresh_token, 0)
    {:ok, %{token: nil, error: nil}}
  end

  @impl true
  def handle_call(:get_token, _from, %{token: token} = state) do
    {:reply, token, state}
  end

  @impl true
  def handle_info(:refresh_token, state) do
    case Teac.OAuth.ClientCredentialFlow.token() do
      {:ok, %{"access_token" => token, "expires_in" => expires_in}} ->
        # Calculate refresh time: expires_in is in seconds, we want to refresh 60 seconds before expiration
        refresh_millis = max(0, (expires_in - 60) * 1000)

        # Schedule next refresh
        Process.send_after(self(), :refresh_token, refresh_millis)

        new_state = %{
          token: token,
          expires_in: expires_in,
          refresh_at: System.monotonic_time(:millisecond) + refresh_millis,
          # clear any previous error
          error: nil
        }

        {:noreply, new_state}

      {:error, reason} ->
        # Retry after 5 seconds on failure
        Process.send_after(self(), :refresh_token, 5_000)

        # Update error but keep existing token if available
        new_state = Map.put(state, :error, reason)
        {:noreply, new_state}
    end
  end
end
