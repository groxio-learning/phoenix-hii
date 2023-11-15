defmodule Words.Game.Word do
  defp get_index(list) do
    Enum.with_index(list, fn guess, index -> {guess, index} end)
  end

  def new(answer, guess) do
    answer_graphemes = String.graphemes(answer)
    guess_graphemes = String.graphemes(guess)

    # ["t", "e"]
    guess_graphemes_indexes = get_index(guess_graphemes)
    answer_graphemes_indexes = get_index(answer_graphemes)

    rejected_keys = guess_graphemes -- answer_graphemes

    Enum.map(rejected_keys, fn guess ->
      # what to do here?
      # dbg(Enum.at(guess_graphemes_indexes, guess))
    end)

    Enum.zip(answer_graphemes, guess_graphemes)
    |> mark_greens()
    |> mark_blacks(rejected_keys)
  end

  defp mark_greens(zipped_list) do
    Enum.map(zipped_list, fn {a, g} ->
      if a == g, do: {g, :green}, else: {g, :yellow}
    end)
  end


  # [{"t", :yellow}, {"a", :yellow}, {"s", :yellow}, {"t", :yellow}, {"e", :yellow}]
  defp mark_blacks(marked_list, rejected_list) do
    # accumulator: {marked list so far, rejected}
    # {"t", :black}
    # {"e", :black}

    # initial_value = {marked_list, rejected_list}



    rev_marked_list = Enum.reverse(marked_list)

    dbg(rejected_list)

    # list = rev_marked_list |> Enum.map(fn {char, color} ->
    #   if char in rejected_list do
    #     #rejected_list = List.delete(rejected_list, char)
    #     {char, :black}
    #   else
    #     {char, color}
    #   end
    # end)


    # dbg(list)
  end

  def show(score) do
    inspect(score)
  end

  # IO.ANSI color code the background
end
