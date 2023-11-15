defmodule Words do
  @moduledoc """
  Documentation for `Words`.
  """

  def start_game(name) do
    # This is a bad idea for production. We are creating a string from an atom.
    process_name = :"#{name}"
    DynamicSupervisor.start_child(:dsup, {Words.Game, process_name})
  end

  def make_move(name, word_guess) do
    process_name = :"#{name}"
    Words.Game.make_guess(process_name, word_guess)
  end
end
