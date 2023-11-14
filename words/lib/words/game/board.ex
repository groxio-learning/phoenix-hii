defmodule Words.Game.Board do
  defstruct [words: [], keyboard: %{}, answer: "hello"]

  def new do
    %__MODULE__{}
  end

  def guess(board, word_guess) do
    %{board | words: [word_guess | board.words]}
    # reducer that accepts a board and a guessed word and returns a new board. the new board has gussed word added
  end

  def score do
    # could be either converter or reducer
    # that accepts a board and return a list of scores
    # list of tuples e.g {character, color}
    # optional: do we need to track scores? / compute the score every time we make a move?
  end
end
