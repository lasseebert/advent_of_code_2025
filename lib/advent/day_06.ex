defmodule Advent.Day06 do
  @moduledoc """
  Day 06
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.map(fn {operator, numbers} -> calc(operator, numbers) end)
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

  defp calc(:+, numbers), do: Enum.sum(numbers)
  defp calc(:*, numbers), do: Enum.reduce(numbers, 1, &Kernel.*/2)

  defp parse(input) do
    {number_rows, [operator_row]} =
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.trim/1)
    end)
    |> Enum.split(-1)

    number_rows =
      number_rows
      |> transpose()
      |> Enum.map(fn row ->
        Enum.map(row, &String.to_integer/1)
      end)

    operator_rows =
      operator_row
      |> Enum.map(fn
        "*" -> :*
        "+" -> :+
      end)

    operator_rows
    |> Enum.zip(number_rows)
  end

  defp transpose(rows) do
    rows
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
