
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

  class Path
    attr_reader :nodes

    def initialize(nodes)
      @nodes = nodes
    end

    def initialize_copy(obj)
      super
      @nodes = obj.nodes.dup
    end

    def last
      nodes.last
    end

    def complete?
      last == 'end'
    end

    def add(node)
      @double_visit ||= visited_small?(node)

      nodes << node
      self
    end

    def visited_small?(node)
      small?(node) && nodes.include?(node)
    end

    def double_visit?
      !!@double_visit
    end

    def small?(node)
      !node.match?(/[[:upper:]]/)
    end
  end

  def part_one_output
    count_paths_except { |p, n| p.visited_small?(n) }
  end

  def part_two_output
    count_paths_except { |p, n| n == 'start' || p.double_visit? && p.visited_small?(n) }
  end

  def count_paths_except(&block)
    paths = [Path.new(['start'])]
    completed_paths = []

    loop do
      new_complete_paths, paths = paths.group_by(&:last).flat_map do |last, ps|
        connected_nodes = adjacent_map[last]
        ps.product(connected_nodes)
          .reject(&block)
          .map { |p, n| p.dup.add(n) }
      end.partition(&:complete?)

      completed_paths.concat(new_complete_paths)

      break if paths.empty?
    end

    completed_paths.size
  end
end
