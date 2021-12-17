
require_relative '../base_solution'
require 'set'
require 'benchmark'

class Solution < BaseSolution
  attr_reader :risks, :length, :width, :nodes

  def initialize(*)
    super

    @risks = input_lines.map { |l| l.chomp.split('').map(&:to_i) }
    @length = @risks.size
    @width = @risks.first.size
    @nodes = @length.times.to_a.product(@width.times.to_a)
  end

  def part_one_output
    shortest_path(risks)
  end

  def part_two_output
    shortest_path(expand(risks))
  end

  OFFSETS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  def neighbours(node, length, width)
    i, j = node
    OFFSETS.map { |di, dj| [i + di, j + dj] }.select { |r, c| r >= 0 && r < length && c >= 0 && c < width }
  end

  def expand(values)
    orig_length = values.size
    orig_width = values.first.size
    length = orig_length * 5
    width = orig_width * 5
    new_values = Array.new(length) { Array.new(width) }

    length.times do |i|
      width.times do |j|
        orig_i = i % orig_length
        orig_j = j % orig_width

        orig_val = values[orig_i][orig_j]

        offset = i / orig_length + j / orig_width

        new_val = orig_val + offset
        new_values[i][j] = new_val > 9 ? new_val - 9 : new_val
      end
    end

    new_values
  end

  def shortest_path(values)
    length = values.size
    width = values.first.size
    nodes = length.times.to_a.product(width.times.to_a)

    distances = {}

    nodes.each do |n|
      distances[n] = Float::INFINITY
    end
    distances[[0, 0]] = 0

    nodes_to_visit = Set.new([[0, 0]])
    visited_nodes = Set.new

    while node = nodes_to_visit.min_by { |n| distances[n] }
      nodes_to_visit.delete(node)
      visited_nodes << node

      neighbours(node, length, width).each do |v|
        next if visited_nodes.include?(v)
        nodes_to_visit << v
        new_distance = distances[node] + values[v.first][v.last]
        distances[v] = new_distance if new_distance < distances[v]
      end
    end

    distances[[length-1, width-1]]
  end
end
