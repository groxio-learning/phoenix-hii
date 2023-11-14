defmodule Words.Game.WordTest do
  use ExUnit.Case
  alias Words.Game.Word

  doctest Word

  describe "new/2" do
    test "returns expected data structure" do
      actual_data = Word.new("short", "court")
      expected_data = [{"c", :yellow}, {"o", :yellow}, {"u", :yellow}, {"r", :green}, {"t", :green}]

      assert actual_data == expected_data
    end
  end
end
