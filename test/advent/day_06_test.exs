defmodule Advent.Day06Test do
  use Advent.Test.Case

  alias Advent.Day06

  @example_input """
  123 328  51 64 
   45 64  387 23 
    6 98  215 314
  *   +   *   +  
  """

  @puzzle_input File.read!("puzzle_inputs/day_06.txt")

  describe "part 1" do
    test "example" do
      assert Day06.part_1(@example_input) == 4_277_556
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day06.part_1(@puzzle_input) == 5_316_572_080_628
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert Day06.part_2(@example_input) == 0
    end

    @tag :skip
    @tag :puzzle_input
    test "puzzle input" do
      assert Day06.part_2(@puzzle_input) == 0
    end
  end
end
