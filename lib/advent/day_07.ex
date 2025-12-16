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
    {splitters, start} = parse(input)

    max_y = splitters |> Enum.map(fn {_x, y} -> y end) |> Enum.max()

    cache = %{}
    {_cache, count} = count_timelines(start, cache, splitters, max_y)
    count
  end

  # Below max y, there is only one timeline
  defp count_timelines({_x, y}, cache, _splitters, max_y) when y > max_y do
    {cache, 1}
  end

  # Do a depth-first search with memoization
  # If a sub-tree has n number of timelines, it will have the same number of timelines
  # for any parent node above it.
  defp count_timelines(pos = {x, y}, cache, splitters, max_y) do
    next_pos = {x, y + 1}

    cond do
      Map.has_key?(cache, pos) ->
        {cache, Map.get(cache, pos)}

      MapSet.member?(splitters, next_pos) ->
        left = {x - 1, y + 1}
        right = {x + 1, y + 1}

        {cache, left_count} = count_timelines(left, cache, splitters, max_y)
        {cache, right_count} = count_timelines(right, cache, splitters, max_y)

        count = left_count + right_count
        cache = Map.put(cache, pos, count)
        {cache, count}

      true ->
        {cache, count} = count_timelines(next_pos, cache, splitters, max_y)
        cache = Map.put(cache, pos, count)
        {cache, count}
    end
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
