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
    input
    |> parse()

    0
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
