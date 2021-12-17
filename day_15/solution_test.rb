
require 'minitest/autorun'
require './solution'

class SolutionTest < Minitest::Test
  def test_example_input_part_one
    solution = Solution.new('./example.txt')

    expected_part_one_output = 40

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_full_input_part_one
    solution = Solution.new('./input.txt')

    expected_part_one_output = 403

    assert_equal expected_part_one_output, solution.part_one_output
  end

  def test_example_input_part_two
    solution = Solution.new('./example.txt')

    expected_part_two_output = 315

    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_full_input_part_two
    solution = Solution.new('./input.txt')

    expected_part_two_output = 2840

    assert_equal expected_part_two_output, solution.part_two_output
  end
end
