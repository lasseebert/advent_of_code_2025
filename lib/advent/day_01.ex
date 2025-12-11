defmodule Advent.Day01 do
  @moduledoc """
  Day 01
  """

  @starting_position 50
  @num_poistions 100

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    input
    |> parse()
    |> Enum.scan(@starting_position, fn {direction, distance}, position ->
      move(position, direction, distance)
    end)
    |> Enum.count(&(&1 == 0))
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

  defp move(position, :left, distance), do: (position - distance + @num_poistions) |> rem(@num_poistions)
  defp move(position, :right, distance), do: (position + distance) |> rem(@num_poistions)

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction(<<turn::binary-size(1), distance::binary>>) do
    {parse_direction(turn), String.to_integer(distance)}
  end

  defp parse_direction("L"), do: :left
  defp parse_direction("R"), do: :right
end
