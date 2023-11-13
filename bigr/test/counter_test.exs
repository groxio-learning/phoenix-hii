defmodule CounterTest do
  use ExUnit.Case

  alias Bigr.Counter

  describe "new/1" do
    test "new/1 returns the expected data structure" do
      assert %{count: count} = Counter.new(42)
      assert count == 42
    end

    test "new/1 throws when input is not an integer" do
      assert_raise(FunctionClauseError, fn -> Counter.new("42") end)
    end
  end

  describe "crc" do
    test "piped" do
      actual =
        42
        |> Counter.new()
        |> assert_count(42)
        |> Counter.inc()
        |> assert_count(43)
        |> Counter.inc()
        |> assert_count(44)
        |> Counter.dec()
        |> assert_count(43)
        |> Counter.show()

      expected = "43"
      assert actual == expected
    end
  end

  defp assert_count(counter, count) do
    assert counter.count == count
    counter
  end

end
