defmodule Advent.Day08Test do
  use Advent.Test.Case

  alias Advent.Day08

  @example_input """
  162,817,812
  57,618,57
  906,360,560
  592,479,940
  352,342,300
  466,668,158
  542,29,236
  431,825,988
  739,650,466
  52,470,668
  216,146,977
  819,987,18
  117,168,530
  805,96,715
  346,949,466
  970,615,88
  941,993,340
  862,61,35
  984,92,344
  425,690,689
  """

  @puzzle_input File.read!("puzzle_inputs/day_08.txt")

  describe "part 1" do
    test "example" do
      assert Day08.part_1(@example_input, 10) == 40
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert Day08.part_1(@puzzle_input, 1000) == 81_536
    end
  end

  describe "part 2" do
    @tag :skip
    test "example" do
      assert Day08.part_2(@example_input) == 0
    end

    @tag :skip
    @tag :puzzle_input
    test "puzzle input" do
      assert Day08.part_2(@puzzle_input) == 0
    end
  end
end
