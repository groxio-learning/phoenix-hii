defmodule BirdleWeb.WordsLive do
  use BirdleWeb, :live_view

  alias Words.Game.Board
  alias Words.Game.Dictionary
  alias BirdleWeb.Guess

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

      <.simple_form for={@form} id="guess" phx-submit="make-guess" phx-change="validate-guess">
        <.input field={@form[:token]} type="hidden" />
        <.input field={@form[:word]} type="text" />
        <:actions>
          <.button :if={@changeset.valid?} class="w-full">Submit</.button>
        </:actions>
      </.simple_form>

      <pre>
        <%= @changeset |> inspect(pretty: true) %>
        <%= @keyboard |> inspect(pretty: true) %>
        <%= @words |> inspect(pretty: true) %>
      </pre>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    random_answer = Dictionary.random_answer()

    changeset = Guess.changeset("")

    board = Board.new(random_answer)

    {:ok,
     assign(
       socket,
       game: board,
       words: board.words,
       keyboard: board.keyboard
     )
     |> update_changeset("")}
  end

  def handle_event("validate-guess", %{"guess" => %{"word" => word}}, socket) do
    {:noreply, update_changeset(socket, word)}
  end

  def handle_event("make-guess", %{"guess" => %{"word" => word}}, socket) do
    {:noreply, socket |> make_move(word) |> update_changeset("")}
  end

  defp update_changeset(socket, word) do
    changeset =
      word
      |> Guess.changeset()
      |> Map.put(:action, :validate)

    assign(socket, changeset: changeset, form: to_form(changeset))
  end

  defp make_move(socket, word) do
    new_board = Board.guess(socket.assigns.game, word)

    assign(socket, game: new_board, words: new_board.words, keyboard: new_board.keyboard)
  end
end
