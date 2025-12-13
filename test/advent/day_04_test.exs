defmodule Advent.Day04Test do
  use Advent.Test.Case

  alias Advent.Day04

  @example_input """
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  @puzzle_input File.read!("puzzle_inputs/day_04.txt")

  describe "part 1" do
    test "example" do
      assert Day04.part_1(@example_input) == 13
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day04.part_1(@puzzle_input) == 1578
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert Day04.part_2(@example_input) == 0
    end

    @tag :skip
    @tag :puzzle_input
    test "puzzle input" do
      assert Day04.part_2(@puzzle_input) == 0
    end
  end
end
