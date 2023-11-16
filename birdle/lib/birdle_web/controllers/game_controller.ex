defmodule BirdleWeb.GameController do
  use BirdleWeb, :controller

  def new(%{assigns: %{current_user: user}} = conn, _params) do
    # never do this in production
    name = user.email

    pid = name |> String.to_atom() |> GenServer.whereis()

    if !pid do
      IO.puts("Starting a new game for #{name}")

      Words.start_game(name)
    end

    redirect(conn, to: "/playing")
  end

  def play(%{assigns: %{current_user: user}} = conn, _params) do
    name = user.email
    render(conn, :play, name: name)
  end

  def guess(%{assigns: %{current_user: user}} = conn, %{"guess" => guess} = params) do
    name = user.email
    Words.make_move(name, guess)
    redirect(conn, to: "/playing")
  end
end
