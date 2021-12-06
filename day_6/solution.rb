
require_relative '../base_solution'

class Solution < BaseSolution
  attr_reader :timers, :timer_tally

  def initialize(*)
    super

    @timers = input_lines.join.split(',').map(&:to_i)
    @timer_tally = @timers.tally
  end

  def part_one_output
    80.times do
      process_generation_naive
    end

    timers.count
  end

  def part_two_output
    256.times do
      process_generation
    end

    timer_tally.values.sum
  end

  def process_generation_naive
    new_timers = 0

    timers.map! do |timer|
      if timer == 0
        new_timers += 1
        6
      else
        timer - 1
      end
    end

    timers.concat(Array.new(new_timers, 8))
  end

  def process_generation
    new_timer_tally = Hash.new(0)
    timer_tally.each do |timer, count|
      if timer == 0
        new_timer_tally[6] += count
        new_timer_tally[8] += count
      else
        new_timer_tally[timer - 1] += count
      end
    end

    @timer_tally = new_timer_tally
  end
end
