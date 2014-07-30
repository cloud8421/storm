defmodule Parser do
  def parse(packet) do
    pairs = packet |> String.split("|")
    do_parse(pairs, %{})
  end

  def do_parse([], acc), do: acc
  def do_parse([h|t], acc) do
    packet = parse_packet(h)
    new_acc = Map.put_new(acc, packet.name, packet.value)
    do_parse(t, new_acc)
  end

  defp parse_packet(packet) do
    [name, format, value] = String.split(packet, ":")
    %{name: name |> String.to_atom, value: parse_value(value, format)}
  end

  defp parse_value(value, "f"), do: String.to_float(value)
  defp parse_value(value, "i"), do: String.to_integer(value)
end
