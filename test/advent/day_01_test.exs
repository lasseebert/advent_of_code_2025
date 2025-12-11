defmodule Advent.Day01Test do
  use Advent.Test.Case

  alias Advent.Day01

  @example_input """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  @puzzle_input File.read!("puzzle_inputs/day_01.txt")

  describe "part 1" do
    test "example" do
      assert Day01.part_1(@example_input) == 3
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day01.part_1(@puzzle_input) == 1092
    end
  end

  describe "part 2" do
    test "example" do
      assert Day01.part_2(@example_input) == 6
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day01.part_2(@puzzle_input) == 6616
    end
  end
end
