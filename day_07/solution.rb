
require_relative '../base_solution'

class Solution < BaseSolution
  attr_reader :positions

  def initialize(*)
    super

    @positions = input_data.split(',').map(&:to_i)
  end

  def part_one_output
    median_position = median(positions).round.to_i

    positions.map { |e| (e - median_position).abs }.sum
  end

  def part_two_output
    ((positions.min)..(positions.max)).map do |target|
      positions.map { |e| (1..(e - target).abs).sum }.sum
    end.min
  end

  def avg(array)
    array.sum / array.size.to_f
  end

  def median(array)
    array.sort[array.size / 2]
  end
end
