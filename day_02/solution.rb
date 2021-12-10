
require_relative '../base_solution'

class Solution < BaseSolution
  def part_one_output
    movements = input_lines
      .map { |l| l.split(' ') }
      .group_by(&:first)
      .transform_values { |numbers| numbers.map(&:last).map(&:to_i).sum }

    movements['forward'] * (movements['down'] - movements['up'])
  end

  def part_two_output
    position = 0
    aim = 0
    depth = 0

    input_lines.map { |l| l.split(' ') }.each do |action, val|
      value = val.to_i

      case action
      when 'forward'
        position += value
        depth += aim * value
      when 'down'
        aim += value
      when 'up'
        aim -= value
      end
    end

    position * depth
  end
end
