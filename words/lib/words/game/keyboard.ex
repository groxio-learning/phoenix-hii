defmodule Words.Game.Keyboard do
  def new do
    for l <- ?a..?z, into: %{}, do: {<<l>>, :white}
  end

  def add_word(keyboard, scores) do
    Enum.reduce(scores, keyboard, &add_letter/2)
  end

  defp add_letter({letter, color}, keyboard) do
    color = greatest_color(color, keyboard[letter])
    Map.put(keyboard, letter, color)
  end

  defp color_weight(color) do
    ~w(white black yellow green)a |> Enum.find_index(fn x -> x == color end)
  end

  defp greatest_color(a, b) do
    if color_weight(a) > color_weight(b), do: a, else: b
  end
end
