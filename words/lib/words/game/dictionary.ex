defmodule Words.Game.Dictionary do
  defp get_file_and_split(path) do
    {:ok, file} = File.read(path)
    String.split(file, "\n")
  end

  def get_answers do
    get_file_and_split("priv/answers.txt")
  end

  def get_guesses do
    get_file_and_split("priv/guesses.txt")
  end

  def random_answer do
    answers = get_answers()
    Enum.random(answers)
  end

  def valid?(word) do
    guesses = get_guesses()
    answers = get_answers()
    Enum.member?(guesses, word) || Enum.member?(answers, word)
  end
end
