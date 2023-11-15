defmodule Words.Game.Board do
  alias Words.Game.{Word, Keyboard}

  defstruct [words: [], keyboard: %{}, answer: "hello"]

  def new do
    %__MODULE__{keyboard: Keyboard.new()}
  end

  def guess(board, word_guess) do
    word = Word.new(board.answer, word_guess)
    %{board | words: [word | board.words], keyboard: Keyboard.add_word(board.keyboard, word)}
  end

  def score do
    # could be either converter or reducer
    # that accepts a board and return a list of scores
    # list of tuples e.g {character, color}
    # optional: do we need to track scores? / compute the score every time we make a move?
  end
end
