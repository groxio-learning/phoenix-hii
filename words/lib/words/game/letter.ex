defmodule Words.Game.Letter do
  alias IO.ANSI

  def show({letter, :white}) do
    ANSI.format([:white_background, letter])
  end

  def show({letter, :black}) do
    ANSI.format([:black_background, letter])
  end

  def show({letter, :yellow}) do
    ANSI.format([:yellow_background, letter])
  end

  def show({letter, :green}) do
    ANSI.format([:green_background, letter])
  end
end
