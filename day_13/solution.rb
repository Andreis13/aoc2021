
require_relative '../base_solution'

class Solution < BaseSolution
  attr_reader :dots, :folds

  def initialize(*)
    super

    dot_data, fold_data = input_data.split("\n\n")

    @dots = dot_data.lines.map { |l| l.chomp.split(',').map(&:to_i) }
    @folds = fold_data.lines.map { |l| axis, val = l.chomp.split(' ').last.split('='); [axis, val.to_i] }
  end

  def part_one_output
    axis, val = folds.first
    if axis == 'x'
      fold_x(val)
    else
      fold_y(val)
    end

    dots.count
  end

  def part_two_output
    folds.each do |axis, val|
      if axis == 'x'
        fold_x(val)
      else
        fold_y(val)
      end
    end

    width = dots.max_by(&:first).first + 1
    length = dots.max_by(&:last).last + 1

    paper = Array.new(length) { Array.new(width) { '.' } }
    dots.each do |x, y|
      paper[y][x] = '#'
    end
    puts
    paper.map(&:join).join("\n").tap { |code| puts code }
  end

  def fold_x(val)
    dots.map! { |x, y| x > val ? [val * 2 - x, y] : [x, y] }.uniq!
  end

  def fold_y(val)
    dots.map! { |x, y| y > val ? [x, val * 2 - y] : [x, y] }.uniq!
  end
end
