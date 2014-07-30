defmodule ParserTest do
  use ExUnit.Case

  test "it parses the sensor payload" do
    payload = "temp:f:23.6|bright:i:4000"
    expected = %{temp: 23.6, bright: 4000}
    assert Parser.parse(payload) == expected
  end
end
