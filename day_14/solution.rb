
require_relative '../base_solution'

class Solution < BaseSolution
  attr_reader :rules, :pair_rules, :tally, :pair_tally
  def initialize(*)
    super

    template_data, rules_data = input_data.split("\n\n")
    template = template_data.split('')
    @rules = rules_data.lines.map do |l|
      k, v = l.chomp.split(' -> ')
      a, b = k.split('')
      [[a, b], v]
    end.to_h
    @pair_rules = @rules.map { |(a, b), v| [[a,b], [[a, v],[v, b]]] }.to_h
    @tally = template.tally
    @pair_tally = template.each_cons(2).tally
  end

  def part_one_output
    min, max = tally_evolution(tally, pair_tally, 10).values.minmax
    max - min
  end

  def part_two_output
    min, max = tally_evolution(tally, pair_tally, 40).values.minmax
    max - min
  end

  def tally_evolution(element_tally, pair_tally, iterations)
    return element_tally if iterations <= 0

    tally_delta = pair_tally.each_with_object(Hash.new(0)) do |(pair, count), obj|
      obj[rules[pair]] += count
    end
    new_tally = element_tally.merge(tally_delta) { |_, a, b| a + b }

    new_pair_tally = pair_tally.each_with_object(Hash.new(0)) do |(pair, count), obj|
      p1, p2 = pair_rules[pair]
      obj[p1] += count
      obj[p2] += count
    end

    tally_evolution(new_tally, new_pair_tally, iterations - 1)
  end
end
