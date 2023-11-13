defmodule BigrTest do
  use ExUnit.Case
  doctest Bigr

  test "greets the world" do
    assert Bigr.hello() == :world
  end
end
