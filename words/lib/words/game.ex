defmodule Words.Game do
  use GenServer

  alias Words.Game.{Board, Dictionary}

  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end

  @impl true
  def init([]) do

  end

  @impl true
  def handle_call({:guess, word}, _from, board) do
    new_state = Board.guess(board, word)
    {:reply, Board.as_map(new_state), new_state}
  end

  @impl true
  def handle_call(:show, _from, board) do
    result =
      board
      |> Map.from_struct()
      |> Map.take([:keyboard, :words])

    {:reply, result, board}
  end

  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def show(board_pid) do
    GenServer.call(board_pid, :show)
  end

  def make_guess(board_pid, word_guess) do
    if Dictionary.valid?(word_guess) do
      {board_pid
       |> GenServer.call({:guess, word_guess})
       |> Board.show()
       |> IO.puts(), "You guessed: #{word_guess}"}
    else
      {:error, "Guess is invalid!"}
    end
  end

  def make_guess_phx(board_pid, word_guess) do
    if Dictionary.valid?(word_guess) do
      {board_pid
       |> GenServer.call({:guess, word_guess})}
    else
      {:error, "Guess is invalid!"}
    end
  end
end
