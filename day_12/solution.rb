
require_relative '../base_solution'
require 'set'

class Solution < BaseSolution
  attr_reader :edges, :adjacent_map

  def initialize(*)
    super

    @edges = input_lines.map do |line|
      line.chomp.split('-')
    end

    @adjacent_map = {}

    @edges.each do |a, b|
      @adjacent_map[a] ||= []
      @adjacent_map[b] ||= []

      @adjacent_map[a] << b
      @adjacent_map[b] << a
    end
  end

  def part_one_output
    count_paths_except { |p, n| small?(n) && p.include?(n) }
  end

  def part_two_output
    count_paths_except { |p, n| n == 'start' || small?(n) && p.include?(n) && path_has_double_visit?(p) }
  end

  def count_paths_except(&block)
    nodes = ['start']
    paths = [['start']]

    completed_paths = []

    loop do
      new_complete_paths, paths = paths.group_by(&:last).map do |last, ps|
        connected_nodes = adjacent_map[last]
        ps.product(connected_nodes)
          .reject(&block)
          .map { |p, n| p.dup << n }
      end.flatten(1).partition { |p| p.last == 'end' }

      completed_paths.concat(new_complete_paths)

      break if paths.empty?
    end

    completed_paths.size
  end

  def small?(node)
    !node.match?(/[[:upper:]]/)
  end

  def path_has_double_visit?(p)
    small_nodes = p.select { |n| small?(n) }
    small_nodes.size != small_nodes.uniq.size
  end
end
