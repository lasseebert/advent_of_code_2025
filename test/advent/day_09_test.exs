defmodule Advent.Day09Test do
  use Advent.Test.Case

  alias Advent.Day09

  @example_input """
  7,1
  11,1
  11,7
  9,7
  9,5
  2,5
  2,3
  7,3
  """

  @puzzle_input File.read!("puzzle_inputs/day_09.txt")

  describe "part 1" do
    test "example" do
      assert Day09.part_1(@example_input) == 50
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day09.part_1(@puzzle_input) == 4_746_238_001
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert Day09.part_2(@example_input) == 0
    end

    @tag :skip
    @tag :puzzle_input
    test "puzzle input" do
      assert Day09.part_2(@puzzle_input) == 0
    end
  end
end
