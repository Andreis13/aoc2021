
require_relative '../base_solution'

class Solution < BaseSolution
  class Line
    attr_reader :x1, :x2, :y1, :y2
    def initialize(p1, p2)
      @x1, @y1 = p1
      @x2, @y2 = p2
    end

    def vertical?
      x1 == x2
    end

    def horizontal?
      y1 == y2
    end

    def points_covered
      if vertical? || horizontal?
        numbers_between(x1, x2).product(numbers_between(y1, y2))
      else
        numbers_between(x1, x2).zip(numbers_between(y1, y2))
      end
    end

    def inspect
      "(#{x1},#{y1} -> #{x2},#{y2})"
    end

    def numbers_between(n1, n2)
      (n1 > n2 ? n1.downto(n2) : n1.upto(n2)).to_a
    end
  end

  attr_reader :lines

  def initialize(*)
    super

    @lines = input_lines.map do |text_line|
      p1, p2 = text_line.chomp.split(' -> ').map { |p| p.split(',').map(&:to_i) }
      Line.new(p1, p2)
    end
  end

  def part_one_output
    lines
      .select { |l| l.horizontal? || l.vertical? }
      .flat_map(&:points_covered)
      .tally
      .count { |_point, number_of_times_covered| number_of_times_covered >= 2 }
  end

  def part_two_output
    lines
      .flat_map(&:points_covered)
      .tally
      .count { |_point, number_of_times_covered| number_of_times_covered >= 2 }
  end
end
