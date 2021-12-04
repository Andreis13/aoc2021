
require 'minitest/autorun'
require './solution'

class SolutionTest < Minitest::Test
  def test_example_input
    solution = Solution.new('./example.txt')

    expected_part_one_output = 198
    expected_part_two_output = 230

    assert_equal expected_part_one_output, solution.part_one_output
    assert_equal expected_part_two_output, solution.part_two_output
  end

  def test_full_input
    solution = Solution.new('./input.txt')

    expected_part_one_output = 2595824
    expected_part_two_output = 2135254

    assert_equal expected_part_one_output, solution.part_one_output
    assert_equal expected_part_two_output, solution.part_two_output
  end
end
