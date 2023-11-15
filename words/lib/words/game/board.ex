defmodule Words.Game.Board do
  alias Words.Game.{Word, Keyboard}

  defstruct [words: [], keyboard: %{}, answer: "hello"]

  def new do
    __struct__()
  end

  def new(answer) do
    %__MODULE__{keyboard: Keyboard.new(), answer: answer}
  end

  def guess(board, word_guess) do
    word = Word.new(board.answer, word_guess)
    %{board | words: [word | board.words], keyboard: Keyboard.add_word(board.keyboard, word)}
  end

  def show(board) do
    """
    #{show_words(board)}

    #{show_keyboard(board)}
    """
  end

  defp show_keyboard(board) do
    Word.show(board.keyboard)
  end

  defp show_words(board) do
    for word <- Enum.reverse(board.words) do
      [Word.show(word), "\n"]
    end
  end
end
