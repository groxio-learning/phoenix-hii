defmodule Bigr.Server do
  use GenServer

  alias Bigr.Counter

  @impl true
  def init(count) do
    {:ok, Counter.new(count)}
  end

  @impl true
  def handle_call(:show, _from, counter) do
    new_state = Counter.show(counter)
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_cast(:inc, counter) do
    {:noreply, Counter.inc(counter)}
  end

  @impl true
  def handle_cast(:dec, counter) do
    {:noreply, Counter.dec(counter)}
  end

  def start_link(count) when is_integer(count) do
    GenServer.start_link(__MODULE__, count)
  end

  def inc(pid) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid) do
    GenServer.cast(pid, :dec)
  end

  def show(pid) do
    GenServer.call(pid, :show)
  end
end
