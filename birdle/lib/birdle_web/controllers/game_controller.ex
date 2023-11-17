defmodule BirdleWeb.GameController do
  use BirdleWeb, :controller

  def new(%{assigns: %{current_user: user}} = conn, _params) do
    name = user.email

    pid = name |> process_name() |> GenServer.whereis()

    if !pid do
      IO.puts("Starting a new game for #{name}")

      Words.start_game(name)
    end

    redirect(conn, to: "/playing")
  end

  def play(%{assigns: %{current_user: user}} = conn, _params) do
    name = user.email
    %{keyboard: keyboard, words: words} = Words.show(user.email)
    render(conn, :play, name: name, keyboard: keyboard, words: words)
  end

  def guess(%{assigns: %{current_user: user}} = conn, %{"guess" => guess} = params) do
    name = user.email
    Words.make_move(name, guess)
    redirect(conn, to: "/playing")
  end

  defp process_name(email) do
    Words.process_name(email)
  end
end
