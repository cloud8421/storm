defmodule StorageTest do
  use ExUnit.Case
  alias Storm.Storage

  @weather_record %{
    id: 123,
    temperature: 32.4,
    brightness: 4000,
    year: 2014,
    month: 8,
    day: 14,
    hours: 9,
    minutes: 14,
    seconds: 0
  }

  setup do
    Storage.empty
    Storage.insert(@weather_record)
  end

  test "it can find the record" do
    assert Storage.find(123) == @weather_record
  end

  test "it can lookup by a value" do
    assert Storage.where(:day, 14) == [@weather_record]
  end

  test "it finds with a function" do
    [record] = Storage.where(fn(rc) ->
      rc.month == 8
    end)
    assert record == @weather_record
  end
end
