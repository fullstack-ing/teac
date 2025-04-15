defmodule TeacTest do
  use ExUnit.Case
  doctest Teac

  test "greets the world" do
    assert Teac.hello() == :world
  end
end
