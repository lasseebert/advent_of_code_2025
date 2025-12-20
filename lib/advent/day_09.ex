defmodule Advent.Day09 do
  @moduledoc """
  Day 09
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    points = parse(input)

    for a <- points, b <- points, a > b do
      area(a, b)
    end
    |> Enum.max()
  end

  defp area({x1, y1}, {x2, y2}) do
    width = abs(x2 - x1) + 1
    height = abs(y2 - y1) + 1
    width * height
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
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end
