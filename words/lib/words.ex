defmodule Words do
  @moduledoc """
  Documentation for `Words`.
  """

  # By default, elixir process registries support atoms.
  # We are converting strings to atoms as an intermediate step
  # note: in production this will crash the atom table when it overflows
  # before deploying to prod, use via tuples instead of atoms
  def start_game(name) do
    # This is a bad idea for production. We are creating a string from an atom.
    process_name = :"#{name}"
    {:ok, _pid} = DynamicSupervisor.start_child(:dsup, {Words.Game, process_name})
  end

  def make_move(name, word_guess) do
    process_name = :"#{name}"
    Words.Game.make_guess(process_name, word_guess)
  end
end
