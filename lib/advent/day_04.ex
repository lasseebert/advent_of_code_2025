defmodule Advent.Day04 do
  @moduledoc """
  Day 04
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    coords = parse(input)

    coords
    |> Enum.filter(&accessible?(&1, coords))
    |> length()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> remove_until_stable(0)
  end

  defp remove_until_stable(coords, count) do
    accessible = Enum.filter(coords, &accessible?(&1, coords))

    if length(accessible) == 0 do
      count
    else
      coords = Enum.reduce(accessible, coords, fn coord, acc -> MapSet.delete(acc, coord) end)
      remove_until_stable(coords, count + length(accessible))
    end
  end

  defp accessible?(coord, coords) do
    coord
    |> neighbours()
    |> Enum.count(&MapSet.member?(coords, &1))
    |> Kernel.<(4)
  end

  defp neighbours({x, y}) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1}
    ]
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _x} -> char == "@" end)
      |> Enum.reduce(acc, fn {_char, x}, acc -> MapSet.put(acc, {x, y}) end)
    end)
  end
end
