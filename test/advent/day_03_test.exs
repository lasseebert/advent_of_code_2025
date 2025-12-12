defmodule Advent.Day03Test do
  use Advent.Test.Case

  alias Advent.Day03

  @example_input """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  @puzzle_input File.read!("puzzle_inputs/day_03.txt")

  describe "part 1" do
    test "example" do
      assert Day03.part_1(@example_input) == 357
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day03.part_1(@puzzle_input) == 17_031
    end
  end

  describe "part 2" do
    test "example" do
      assert Day03.part_2(@example_input) == 3_121_910_778_619
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day03.part_2(@puzzle_input) == 168_575_096_286_051
    end
  end
end
