defmodule Bigr.Server do
  use GenServer

  alias Bigr.Counter

  # build a child_spec function that returns a map with a name
  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end

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

  def start_link(name) do
    IO.puts("Starting #{name}")
    GenServer.start_link(__MODULE__, 0, name: name)
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
