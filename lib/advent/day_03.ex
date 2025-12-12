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
    # Start with the first m batteries
    {selected, rest} = Enum.split(batteries, n)
    joltage(selected, rest)
  end

  # Termination case, just read the number
  defp joltage(selected, []) do
    selected
    |> Enum.reduce(0, fn num, acc -> acc * 10 + num end)
  end

  # Find the left-most pair where the left is less than the right, then remove the left.
  # If no such pair exists, throw away the last added candidate and continue.
  defp joltage(selected, [next | rest]) do
    candidates = selected ++ [next]

    case remove_lower_lead([hd(candidates)], tl(candidates)) do
      {:removed, candidates} ->
        joltage(candidates, rest)

      :none_found ->
        # Remove the newly added candidate
        joltage(selected, rest)
    end
  end

  # Use a zipper structure to traverse the list
  # Termination case: Found a lower lead
  defp remove_lower_lead([a | rest_left], [b | rest_right]) when a < b do
    {:removed, Enum.reverse(rest_left) ++ [b | rest_right]}
  end

  # Continue searching
  defp remove_lower_lead(left, [b | rest_right]) do
    remove_lower_lead([b | left], rest_right)
  end

  # Termination case: No lower lead found
  defp remove_lower_lead(_left, []) do
    :none_found
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
