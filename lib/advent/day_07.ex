defmodule Advent.Day07 do
  @moduledoc """
  Day 07
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    {splitters, start} = parse(input)

    max_y = splitters |> Enum.map(fn {_x, y} -> y end) |> Enum.max()

    count_splits([start], MapSet.new(), 0, splitters, max_y)
  end

  # Current row is empty, move to next row
  defp count_splits([], next_row, count, splitters, max_y) do
    count_splits(Enum.into(next_row, []), MapSet.new(), count, splitters, max_y)
  end

  # Reached beyond max y, return count
  defp count_splits([{_x, y} | _rest], _next_row, count, _splitters, max_y) when y > max_y do
    count
  end

  # Move beam one step down, possibly splitting
  defp count_splits([{x, y} | rest], next_row, count, splitters, max_y) do
    next_pos = {x, y + 1}

    if MapSet.member?(splitters, next_pos) do
      left = {x - 1, y + 1}
      right = {x + 1, y + 1}

      count_splits(
        rest,
        next_row |> MapSet.put(left) |> MapSet.put(right),
        count + 1,
        splitters,
        max_y
      )
    else
      count_splits(rest, MapSet.put(next_row, next_pos), count, splitters, max_y)
    end
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()

    0
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce({MapSet.new(), nil}, fn {line, y}, {splitters, start} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reject(fn {char, _x} -> char == "." end)
      |> Enum.reduce({splitters, start}, fn {char, x}, {splitters, start} ->
        case char do
          "S" -> {splitters, {x, y}}
          "^" -> {MapSet.put(splitters, {x, y}), start}
        end
      end)
    end)
  end
end
