defmodule Words.Game.Board do
  defstruct [words: [], keyboard: %{}, answer: "hello"]

  def new do
    %__MODULE__{}
  end

  def guess(board, word_guess) do

  end
end
