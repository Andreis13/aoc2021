
require_relative '../base_solution'

class Solution < BaseSolution
  OFFSETS = [-1, 0, 1].product([-1, 0, 1]).tap { |os| os.delete([0, 0]) }

  attr_reader :energy_levels, :length, :width, :energy_levels_count

  def initialize(*)
    super

    @energy_levels = input_lines.map { |line| line.chomp.split('').map(&:to_i) }
    @length = @energy_levels.size
    @width = @energy_levels.first.size

    @energy_levels_count = @energy_levels.sum { |line| line.size }
  end

  def part_one_output
    100.times.map { step }.sum
  end

  def part_two_output
    (1..).each do |n|
      return n if step == energy_levels_count
    end
  end

  def step
    to_flash = []
    flashed = []

    length.times do |i|
      width.times do |j|
        energy_levels[i][j] += 1
        to_flash << [i, j] if energy_levels[i][j] > 9
      end
    end

    while coords = to_flash.shift
      r, c = coords
      flashed << [r, c]
      adjacent_coords(r, c).each do |i, j|
        energy_levels[i][j] += 1
        next if energy_levels[i][j] <= 9 || flashed.include?([i, j]) || to_flash.include?([i, j])
        to_flash << [i, j]
      end
    end

    length.times do |i|
      width.times do |j|
        energy_levels[i][j] = 0 if energy_levels[i][j] > 9
      end
    end

    flashed.size
  end

  def adjacent_coords(i, j)
    OFFSETS.map { |di, dj| [i + di, j + dj] }.select { |r, c| r >= 0 && r < length && c >= 0 && c < width }
  end
end
