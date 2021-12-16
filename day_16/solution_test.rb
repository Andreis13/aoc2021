
require 'minitest/autorun'
require './solution'

class SolutionTest < Minitest::Test
  def test_example_1_input_part_one
    solution = Solution.new('./example_1.txt')

    expected_part_one_output = 16

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_2_input_part_one
    solution = Solution.new('./example_2.txt')

    expected_part_one_output = 12

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_3_input_part_one
    solution = Solution.new('./example_3.txt')

    expected_part_one_output = 23

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_4_input_part_one
    solution = Solution.new('./example_4.txt')

    expected_part_one_output = 31

    assert_equal expected_part_one_output, solution.part_one_output
  end

  # def test_example_5_input_part_one
  #   solution = Solution.new('./example_5.txt')

  #   expected_part_one_output = 2021

  #   assert_equal expected_part_one_output, solution.part_one_output
  # end

  def test_full_input_part_one
    solution = Solution.new('./input.txt')

    expected_part_one_output = 977

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_1_input_part_two
    solution = Solution.new('./example_two_1.txt')

    expected_part_two_output = 3

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_2_input_part_two
    solution = Solution.new('./example_two_2.txt')

    expected_part_two_output = 54

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_3_input_part_two
    solution = Solution.new('./example_two_3.txt')

    expected_part_two_output = 7

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_4_input_part_two
    solution = Solution.new('./example_two_4.txt')

    expected_part_two_output = 9

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_5_input_part_two
    solution = Solution.new('./example_two_5.txt')

    expected_part_two_output = 1

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_6_input_part_two
    solution = Solution.new('./example_two_6.txt')

    expected_part_two_output = 0

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_7_input_part_two
    solution = Solution.new('./example_two_7.txt')

    expected_part_two_output = 0

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_8_input_part_two
    solution = Solution.new('./example_two_8.txt')

    expected_part_two_output = 1

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_full_input_part_two
    solution = Solution.new('./input.txt')

    expected_part_two_output = 101501020883

    assert_equal expected_part_two_output, solution.part_two_output
  end
end
