defmodule Advent.Day05 do
  @moduledoc """
  Day 05
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    {ranges, ids} = parse(input)

    Enum.count(ids, fn id ->
      Enum.any?(ranges, fn range -> id in range end)
    end)
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    {ranges, _ids} = parse(input)

    ranges
    |> merge_ranges()
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  # Merge overlapping ranges. This can be done in O(n) after we have sorted it
  # (which is O(n log n))
  defp merge_ranges(ranges) do
    ranges
    |> Enum.sort_by(& &1.first)
    |> merges_ranges([])
  end

  # Termination case, all is merged, just return the accumulated list
  defp merges_ranges([], acc), do: acc

  # First item, just add it to the accumulator
  defp merges_ranges([current | rest], []), do: merges_ranges(rest, [current])

  # Any item only needs to be compared to the last merged range
  defp merges_ranges([current | rest], [last_merged | acc_rest]) do
    if current.first <= last_merged.last + 1 do
      new_merged = last_merged.first..Enum.max([last_merged.last, current.last])
      merges_ranges(rest, [new_merged | acc_rest])
    else
      merges_ranges(rest, [current, last_merged | acc_rest])
    end
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n\n", trim: true)
    |> then(fn [ranges_block, numbers_block] ->
      {
        parse_ranges(ranges_block),
        parse_numbers(numbers_block)
      }
    end)
  end

  defp parse_ranges(block) do
    block
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [start_str, end_str] = String.split(line, "-", trim: true)
      String.to_integer(start_str)..String.to_integer(end_str)
    end)
  end

  defp parse_numbers(block) do
    block
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
