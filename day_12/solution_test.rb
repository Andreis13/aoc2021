
require 'minitest/autorun'
require './solution'

class SolutionTest < Minitest::Test
  def test_example_1_input_part_one
    solution = Solution.new('./example_1.txt')

    expected_part_one_output = 10

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_2_input_part_one
    solution = Solution.new('./example_2.txt')

    expected_part_one_output = 19

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_3_input_part_one
    solution = Solution.new('./example_3.txt')

    expected_part_one_output = 226

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_full_input_part_one
    solution = Solution.new('./input.txt')

    expected_part_one_output = 5576

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_1_input_part_two
    solution = Solution.new('./example_1.txt')

    expected_part_two_output = 36

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_2_input_part_two
    solution = Solution.new('./example_2.txt')

    expected_part_two_output = 103

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_example_3_input_part_two
    solution = Solution.new('./example_3.txt')

    expected_part_two_output = 3509

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_full_input_part_two
    solution = Solution.new('./input.txt')

    expected_part_two_output = 152837

    assert_equal expected_part_two_output, solution.part_two_output
  end
end
