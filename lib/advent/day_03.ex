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
    |> Enum.map(&joltage_n(&1, 2))
    |> Enum.sum()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> Enum.map(&joltage_n(&1, 12))
    |> Enum.sum()
  end

  defp joltage_n(batteries, n) do
    {selected, rest} = Enum.split(batteries, n)
    joltage(selected, rest)
  end

  # Termination case, just read the number
  defp joltage(selected, []) do
    selected
    |> Enum.reduce(0, fn num, acc -> acc * 10 + num end)
  end

  defp joltage(selected, [next | rest]) do
    candidates = selected ++ [next]
    # Find the first pair where the second is larger than the first
    candidates
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.find_index(fn [a, b] -> b > a end)
    |> case do
      nil ->
        # No such pair, keep what we have
        joltage(selected, rest)

      index ->
        {first_part, [_throwaway | second_part]} = Enum.split(candidates, index)
        joltage(first_part ++ second_part, rest)
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
