defmodule Bigr.Service do
  alias Bigr.Counter, as: Counter

  # These run on the client
  def start_link(count) do
    spawn_link(fn -> loop(Counter.new(count)) end)
  end

  def inc(pid) do
    send(pid, :inc)
  end

  def dec(pid) do
    send(pid, :dec)
  end

  def show(pid) do
    send(pid, {:show, self()})
    receive do
      msg -> msg
    end
  end

  # These run on the server
  def loop(counter) do
    counter
    |> listen()
    |> loop()
  end

  def listen(counter) do
    receive do
      :inc -> Counter.inc(counter)
      :dec -> Counter.dec(counter)
      {:show, from_pid} ->
        send(from_pid, Counter.show(counter))
        counter
    end
  end
end
