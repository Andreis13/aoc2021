
require_relative '../base_solution'

class Solution < BaseSolution
  attr_reader :points, :length, :width

  class Lowpoint
    attr_reader :value, :row, :col

    def initialize(value, row, col)
      @value = value
      @row = row
      @col = col
    end
  end

  def initialize(*)
    super
    @points = input_lines.map { |line| line.chomp.split('').map(&:to_i) }
    @length = @points.size
    @width = @points.first.size
  end

  def part_one_output
    low_points = find_lowpoints

    low_points.sum(&:value) + low_points.size
  end

  def part_two_output
    find_lowpoints.map { |p| find_basin_size(p) }.sort_by { |v| -v }.take(3).inject(:*)
  end

  def find_lowpoints
    low_points = []

    points.each_with_index do |row, i|
      row.each_with_index do |point, j|
        low_points << Lowpoint.new(point, i, j) if adjacent_coords_values(i, j).all? { |v| v > point }
      end
    end

    low_points
  end

  def adjacent_coords_values(i, j)
    adjacent_coords(i, j).map { |r, c| points[r][c] }
  end

  def adjacent_coords(i, j)
    offsets = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1]
    ]

    offsets
      .map { |di, dj| [i + di, j + dj] }
      .select { |row, col| row >= 0 && row < length && col >= 0 && col < width }
  end

  def find_basin_size(low_point)
    visited_coords = []

    coords_to_visit = [[low_point.row, low_point.col]]

    while coords = coords_to_visit.shift
      visited_coords << coords
      basin_neighbours = adjacent_coords(coords.first, coords.last).reject do |cs|
        visited_coords.include?(cs) || coords_to_visit.include?(cs) || points[cs.first][cs.last] == 9
      end

      coords_to_visit.concat(basin_neighbours)
    end

    visited_coords.size
  end
end
