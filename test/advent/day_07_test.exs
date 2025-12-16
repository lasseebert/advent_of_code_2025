defmodule Advent.Day07Test do
  use Advent.Test.Case

  alias Advent.Day07

  @example_input """
  .......S.......
  ...............
  .......^.......
  ...............
  ......^.^......
  ...............
  .....^.^.^.....
  ...............
  ....^.^...^....
  ...............
  ...^.^...^.^...
  ...............
  ..^...^.....^..
  ...............
  .^.^.^.^.^...^.
  ...............
  """

  @puzzle_input File.read!("puzzle_inputs/day_07.txt")

  describe "part 1" do
    test "example" do
      assert Day07.part_1(@example_input) == 21
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day07.part_1(@puzzle_input) == 1524
    end
  end

  describe "part 2" do
    test "example" do
      assert Day07.part_2(@example_input) == 40
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day07.part_2(@puzzle_input) == 32_982_105_837_605
    end
  end
end
