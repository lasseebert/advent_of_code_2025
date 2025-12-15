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
    |> parse_1()
    |> Enum.map(fn {operator, numbers} -> calc(operator, numbers) end)
    |> Enum.sum()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse_2()
    |> Enum.map(fn {operator, numbers} -> calc(operator, numbers) end)
    |> Enum.sum()
  end

  defp calc(:+, numbers), do: Enum.sum(numbers)
  defp calc(:*, numbers), do: Enum.reduce(numbers, 1, &Kernel.*/2)

  # Parse according to part 1
  #
  # * Read all numbers left to right
  # * Transpose to get columns
  # * Pair each column with its operator
  defp parse_1(input) do
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

    operator_row
    |> Enum.map(&parse_operator/1)
    |> Enum.zip(number_rows)
  end

  # Parse according to part 2
  #
  # * Read all characters left to right
  # * Transpose to get columns of digits/operators/spaces
  # * Chunk columns into groups separated by all-space columns
  # * For each chunk, the first column contains the operator (last character)
  #   and the rest are digits of numbers to be combined
  defp parse_2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> transpose()
    |> Enum.chunk_while(
      nil,
      fn column, acc ->
        cond do
          # The operator is in the first column
          acc == nil ->
            {digits, [operator]} = Enum.split(column, -1)
            operator = parse_operator(operator)
            {:cont, {operator, [parse_number(digits)]}}

          # The delimitir is all spaces
          Enum.all?(column, &(&1 == " ")) ->
            {:cont, acc, nil}

          # All in between are numbers to be added to the current chunk
          true ->
            {operator, numbers} = acc
            {:cont, {operator, [parse_number(column) | numbers]}}
        end
      end,
      # Last chunk
      fn acc -> {:cont, acc, acc} end
    )
  end

  defp transpose(rows) do
    rows
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp parse_operator("*"), do: :*
  defp parse_operator("+"), do: :+

  defp parse_number(digits) do
    digits
    |> Enum.join()
    |> String.trim()
    |> String.to_integer()
  end
end
