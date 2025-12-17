defmodule Advent.Day08 do
  @moduledoc """
  Day 08
  """

  @doc """
  Part 1

  Naive solution. Runs in around 0.4 seconds on my machine for the puzzle input.
  """
  @spec part_1(String.t(), integer) :: integer
  def part_1(input, num_pairs) do
    points = parse(input)

    # Generate all unique pairs of points, sorted by distance
    sorted_pairs =
      for a <- points,
          b <- points,
          a < b do
        {sortable_distance(a, b), {a, b}}
      end
      |> Enum.sort()
      |> Enum.map(fn {_dist, pair} -> pair end)

    points
    # Create groups with each point in its own group
    |> Enum.into(%{}, fn point -> {point, MapSet.new([point])} end)
    # Iterate num_pairs times, merging groups as we go
    |> iterate_groups(sorted_pairs, num_pairs)
    # Get unique groups from mapping from point to group
    |> Enum.map(fn {_point, group} -> group end)
    |> Enum.uniq()
    # Multiply sizes of the three largest groups
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(1, &Kernel.*/2)
  end

  defp iterate_groups(groups, _sorted_pairs, 0), do: groups

  defp iterate_groups(groups, [{a, b} | rest], remaining) do
    group_a = Map.get(groups, a)
    group_b = Map.get(groups, b)

    if MapSet.member?(group_a, b) do
      iterate_groups(groups, rest, remaining - 1)
    else
      merged_group = MapSet.union(group_a, group_b)

      # Update all points in the merged group to point to the new merged group
      updated_groups =
        merged_group
        |> Enum.reduce(groups, fn point, acc ->
          Map.put(acc, point, merged_group)
        end)

      iterate_groups(updated_groups, rest, remaining - 1)
    end
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

  # We skip taking the square root since we only care about relative distances
  defp sortable_distance({x1, y1, z1}, {x2, y2, z2}) do
    (x1 - x2) * (x1 - x2) +
      (y1 - y2) * (y1 - y2) +
      (z1 - z2) * (z1 - z2)
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
