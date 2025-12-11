defmodule Advent.Day02Test do
  use Advent.Test.Case

  alias Advent.Day02

  @example_input """
  11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
  1698522-1698528,446443-446449,38593856-38593862,565653-565659,
  824824821-824824827,2121212118-2121212124
  """

  @puzzle_input File.read!("puzzle_inputs/day_02.txt")

  describe "part 1" do
    test "example" do
      assert Day02.part_1(@example_input) == 1_227_775_554
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day02.part_1(@puzzle_input) == 21_898_734_247
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert Day02.part_2(@example_input) == 0
    end

    @tag :skip
    @tag :puzzle_input
    test "puzzle input" do
      assert Day02.part_2(@puzzle_input) == 0
    end
  end
end
