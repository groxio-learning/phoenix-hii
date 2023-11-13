defmodule Bigr.Counter do

  def new(count) when is_integer(count) do
    %{count: count}
  end

  def inc(%{count: count}) do
    %{count: count + 1}
  end

  def dec(%{count: count }) do
    %{count: count - 1}
  end

  def show(%{count: count}) do
    inspect(count)
  end
end
