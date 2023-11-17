defmodule Words do
  @moduledoc """
  Documentation for `Words`.
  """

  # By default, elixir process registries support atoms.
  # We are converting strings to atoms as an intermediate step
  # note: in production this will crash the atom table when it overflows
  # before deploying to prod, use via tuples instead of atoms
  def start_game(email) do
    {:ok, _pid} = DynamicSupervisor.start_child(:dsup, {Words.Game, process_name(email)})
  end

  def make_move(email, word_guess) do
    Words.Game.make_guess(process_name(email), word_guess)
  end

  def process_name(email) do
    {:via, Registry, {Words.Via, email}}
  end
end
