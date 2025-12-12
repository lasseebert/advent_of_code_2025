defmodule Advent.Day03 do
  @moduledoc """
  Day 03
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.map(&joltage_2/1)
    |> Enum.sum()
  end

  defp joltage_2([a, b | rest]), do: joltage_2(a, b, rest)

  defp joltage_2(a, b, []), do: a * 10 + b
  defp joltage_2(a, b, [c | rest]) when b > a, do: joltage_2(b, c, rest)
  defp joltage_2(a, b, [c | rest]) when c > b, do: joltage_2(a, c, rest)
  defp joltage_2(a, b, [_c | rest]), do: joltage_2(a, b, rest)

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> Enum.map(&joltage_12/1)
    |> Enum.sum()
  end

  # Init
  defp joltage_12(batteries), do: joltage_12([], batteries)

  # Termination case, just read the number
  defp joltage_12(selected, []) do
    selected
    |> Enum.reduce(0, fn n, acc -> acc * 10 + n end)
  end

  defp joltage_12(selected, [next | rest]) when length(selected) < 12 do
    joltage_12(selected ++ [next], rest)
  end

  defp joltage_12(selected, [next | rest]) do
    candidates = selected ++ [next]
    # Find the first pair where the second is larger than the first
    candidates
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.find_index(fn [a, b] -> b > a end)
    |> case do
      nil ->
        # No such pair, keep what we have
        joltage_12(selected, rest)

      index ->
        {first_part, [_throwaway | second_part]} = Enum.split(candidates, index)
        joltage_12(first_part ++ second_part, rest)
    end
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
