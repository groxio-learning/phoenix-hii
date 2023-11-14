defmodule Words.Game.Word do
  def new(answer, guess) do
    answer_graphemes = String.graphemes(answer)
    guess_graphemes = String.graphemes(guess)

    Enum.zip(answer_graphemes, guess_graphemes)
    |> mark_greens()
  end

  defp mark_greens(zipped_list) do
    Enum.map(zipped_list, fn {a, g} ->
      if a == g, do: {g, :green}, else: {g, :yellow}
    end)
  end

  def show(score) do
    inspect(score)
  end

  # IO.ANSI color code the background
end
