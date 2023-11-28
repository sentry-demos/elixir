defmodule Helpers.GenServer do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def crash do
    GenServer.cast(__MODULE__, :crash)
    :ok
  end

  @impl true
  def init(_args), do: {:ok, nil}

  @impl true
  def handle_cast(:crash, _state), do: raise "Crashing Genserver"
end

