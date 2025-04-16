defmodule Teac.Scopes.Helper do
  @moduledoc """
  common functions macro
  """

  defmacro __using__(_opts) do
    quote do
      @doc """
      Retrieves the scope string corresponding to the given atom key.

      ## Examples

          iex> YourModule.get(:example_key)
          "example:scope"
      """
      def get(key), do: Map.fetch!(@scope_map, key)

      @doc "Returns the entire map of scope atoms to scope strings."
      def all, do: @scope_map

      @doc "Returns a list of all valid scope strings."
      def all_values, do: Map.values(@scope_map)

      @doc "Returns a list of all valid scope atoms."
      def all_keys, do: Map.keys(@scope_map)
    end
  end
end
