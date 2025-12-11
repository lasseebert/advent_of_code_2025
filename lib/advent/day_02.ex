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
    |> Enum.filter(&invalid_id_part_1?/1)
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp invalid_id_part_1?(id) do
    id
    |> Integer.digits()
    |> then(fn digits ->
      {first, last} = Enum.split(digits, div(length(digits), 2))

      first == last
    end)
  end

  @doc """
  Part 2

  Naive solution - runs in around 5 seconds on my machine
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
    |> Enum.flat_map(&Enum.into(&1, []))
    |> Enum.filter(&invalid_id_part_2?/1)
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp invalid_id_part_2?(id) when id < 10, do: false
  defp invalid_id_part_2?(id) do
    digits = Integer.digits(id)
    len = length(digits)

    Enum.any?(1..div(len, 2), fn sequence_length ->
      Enum.chunk_every(digits, sequence_length)
        |> Enum.uniq()
        |> length() == 1
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
