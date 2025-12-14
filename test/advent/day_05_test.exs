defmodule Advent.Day05Test do
  use Advent.Test.Case

  alias Advent.Day05

  @example_input """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  @puzzle_input File.read!("puzzle_inputs/day_05.txt")

  describe "part 1" do
    test "example" do
      assert Day05.part_1(@example_input) == 3
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day05.part_1(@puzzle_input) == 563
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert Day05.part_2(@example_input) == 0
    end

    @tag :skip
    @tag :puzzle_input
    test "puzzle input" do
      assert Day05.part_2(@puzzle_input) == 0
    end
  end
end
