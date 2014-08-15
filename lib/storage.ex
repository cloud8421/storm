defmodule Storm.Storage do
  use GenServer

  # Public API

  def insert(weather_record) do
    GenServer.cast(__MODULE__, {:insert, weather_record})
  end

  def all do
    GenServer.call(__MODULE__, :all)
  end

  def find(id) do
    GenServer.call(__MODULE__, {:find, id})
  end

  def where(type, value) do
    GenServer.call(__MODULE__, {:where, type, value})
  end

  def where(function) do
    GenServer.call(__MODULE__, {:where, function})
  end

  def empty do
    GenServer.cast(__MODULE__, :empty)
  end

  # GenServer callbacks

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:where, type, value}, _from, records) do
    matched = Enum.filter(records, fn(record) ->
      record[type] == value
    end)
    {:reply, matched, records}
  end

  def handle_call({:where, ff}, _from, records) do
    matched = Enum.filter(records, fn(r) -> ff.(r) end)
    {:reply, matched, records}
  end

  def handle_call(:all, _from, records) do
    {:reply, records, records}
  end

  def handle_call({:find, id}, _from, records) do
    record = Enum.find(records, fn(record) ->
      record.id == id
    end)
    {:reply, record, records}
  end

  def handle_cast({:insert, weather_record}, records) do
    {:noreply, [weather_record | records]}
  end

  def handle_cast(:empty, _records) do
    {:noreply, []}
  end
end
