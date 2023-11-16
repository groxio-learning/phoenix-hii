defmodule BirdleWeb.GameController do
  use BirdleWeb, :controller

  def play(%{assigns: %{current_user: user}} = conn, _params) do
    # never do this in production
    name = String.to_atom(user.email)
    pid = GenServer.whereis(name)

    if !pid do
      Words.start_game(name)
    end

    render(conn, :play, name: name)
    # text(conn, "hello world")
  end
end
