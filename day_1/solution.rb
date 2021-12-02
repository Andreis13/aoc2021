
require_relative '../base_solution'

class Solution < BaseSolution
  def part_one_output
    input_lines.map(&:to_i).each_cons(2).count { |a, b| b > a }
  end

  def part_two_output
    input_lines.map(&:to_i).each_cons(3).map(&:sum).each_cons(2).count { |a, b| b > a }
  end
end
