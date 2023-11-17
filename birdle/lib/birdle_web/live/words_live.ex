defmodule BirdleWeb.WordsLive do
  use BirdleWeb, :live_view

  alias Words.Game.Board
  alias Words.Game.Dictionary

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <header class="flex items-center justify-between gap-6" }>
        <div>
          <h1 class="text-lg font-semibold leading-8 text-zinc-800">
            Hello, <%= @current_user.email %>
          </h1>
        </div>
      </header>

      <br />
      <br />
      <hr />
      <br />
      <br />

      <div class="grid grid-cols-5 gap-4 text-center font-bold">
        <%= for word <- @words do %>
        <.word tiles={word} />
        <% end %>
      </div>

      <br />
      <br />
      <hr />
      <br />
      <br />

      <div class="grid grid-cols-10 gap-3 text-center font-bold">
        <.word tiles={@keyboard} />
        <div></div>
        <div></div>
      </div>

      <pre>
        <%= @keyboard |> inspect(pretty: true) %>
        <%= @words |> inspect(pretty: true) %>
      </pre>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    random_answer = Dictionary.random_answer()

    board = Board.new(random_answer)

    {:ok, assign(socket, game: board, words: board.words, keyboard: board.keyboard)}
  end
end
