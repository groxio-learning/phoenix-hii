defmodule BirdleWeb.Components.Tile do
  use Phoenix.Component

  attr :letter, :string, required: true
  attr :color, :atom, default: :white


  def tile(assigns) do
    ~H"""
    <div class={"#{background(@color)} #{foreground(@color)} pt-1 pb-1 rounded"}>
      <%= @letter %>
    </div>
    """
  end

  attr :tiles, :list, required: true

  def word(assigns) do
    ~H"""
    <%= for {letter, color} <- @tiles do %>
    <.tile letter={letter} color={color} />
    <% end %>
    """
  end

  defp background(color) do
    case color do
      :green -> "bg-green-600"
      :yellow -> "bg-yellow-500"
      :white -> "bg-white"
      :black -> "bg-gray-500"
    end
  end

  defp foreground(color) do
    case color do
      :green -> "text-white"
      :yellow -> "text-white"
      :white -> "text-black"
      :black -> "text-white"
    end
  end
end
