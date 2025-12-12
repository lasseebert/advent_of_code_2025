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
    |> Enum.map(&joltage/1)
    |> Enum.sum()
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

  defp joltage([a, b | rest]), do: joltage(a, b, rest)

  defp joltage(a, b, []), do: a * 10 + b
  defp joltage(a, b, [c | rest]) when b > a, do: joltage(b, c, rest)
  defp joltage(a, b, [c | rest]) when c > b, do: joltage(a, c, rest)
  defp joltage(a, b, [_c | rest]), do: joltage(a, b, rest)

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
