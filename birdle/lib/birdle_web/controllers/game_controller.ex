defmodule BirdleWeb.GameController do
  use BirdleWeb, :controller

  def new(%{assigns: %{current_user: user}} = conn, _params) do
    # never do this in production
    name = user.email

    pid = name |> String.to_atom() |> GenServer.whereis()

    if !pid do
      IO.puts("Starting a new game for #{name}")

      Words.start_game(name)
      # IO.inspect(:sys.get_state(GenServer.whereis(:"grant@hiivemarkets.com")))
    end

    redirect(conn, to: "/playing")
    # render(conn, :play, name: name)
    # text(conn, "hello world")
  end

  def play(%{assigns: %{current_user: user}} = conn, _params) do
    name = user.email

    render(conn, :play, name: name)

    # show a phoenix form, make a guess and submit

  end

  def accept_guess(%{assigns: %{current_user: user}} = conn, params) do
    dbg(params)
  end
end
