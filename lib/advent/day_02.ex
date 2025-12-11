defmodule Advent.Day02 do
  @moduledoc """
  Day 02
  """

  @doc """
  Part 1

  Naive solution
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.flat_map(&Enum.into(&1, []))
    |> Enum.filter(&invalid_id?/1)
    |> Enum.reduce(0, &(&1 + &2))
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

  defp invalid_id?(id) do
    id
    |> Integer.digits()
    |> then(fn digits ->
      {first, last} = Enum.split(digits, div(length(digits), 2))

      first == last
    end)
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split(~r/\s*,\s*/, trim: true)
    |> Enum.map(&parse_range/1)
  end

  defp parse_range(range_str) do
    range_str
    |> String.split("-", parts: 2, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> then(fn [start_num, end_num] -> start_num..end_num end)
  end
end
