defmodule Words.Game.Word do
  alias Words.Game.Letter

  def new(answer, guess) do
    answer_graphemes = String.graphemes(answer)
    guess_graphemes = String.graphemes(guess)

    missing_list = guess_graphemes -- answer_graphemes

    Enum.zip(answer_graphemes, guess_graphemes)
    |> mark_greens()
    |> mark_blacks(missing_list)
  end

  defp mark_greens(zipped_list) do
    Enum.map(zipped_list, fn {a, g} ->
      if a == g, do: {g, :green}, else: {g, :yellow}
    end)
  end


  # [{"t", :yellow}, {"a", :yellow}, {"s", :yellow}, {"t", :yellow}, {"e", :yellow}]
  defp mark_blacks(marked_list, missing_list) do
    acc = Enum.with_index(marked_list)

    Enum.reduce(missing_list, acc, &mark_one_letter_black/2)
      |> Enum.map(fn {value, _index} -> value end)
  end

  # {{"t", :yellow}, 0}, {{"e", :yellow}, 4}
  defp mark_one_letter_black(missing_letter, acc) do
    {{l, _c}, i} =
      Enum.find(acc, fn {{letter, color}, _index} ->
        color == :yellow && letter == missing_letter
      end)

    List.replace_at(acc, i, {{l, :black}, i})
  end

  def show(score) do
    # use IO.ANSI color code the background
    Enum.map(score, &Letter.show/1)
  end
end
