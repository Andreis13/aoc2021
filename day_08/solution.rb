
require_relative '../base_solution'

require 'set'

class Solution < BaseSolution
  class Display
    attr_reader :code, :output_values

    def initialize(code, output_values)
      @code = code.map { |c| Set.new(c.split('')) }
      @output_values = output_values.map { |c| Set.new(c.split('')) }
    end

    def numeric_value
      digit_map = build_digit_map

      output_values.map { |val| digit_map[val] }.join.to_i
    end

    def build_digit_map
      signal_to_digit = {}

      signals = code

      one = find_and_remove!(signals) { |s| s.size == 2 }
      seven = find_and_remove!(signals) { |s| s.size == 3 }
      four = find_and_remove!(signals) { |s| s.size == 4 }
      eight = find_and_remove!(signals) { |s| s.size == 7 }
      three = find_and_remove!(signals) { |s| s.size == 5 && s.superset?(one) }
      five = find_and_remove!(signals) { |s| s.size == 5 && (four - s).size == 1 }
      two = find_and_remove!(signals) { |s| s.size == 5 }
      nine = find_and_remove!(signals) { |s| s.superset?(three) }
      zero = find_and_remove!(signals) { |s| s.superset?(one) }
      six = signals.first

      signal_to_digit[zero] = '0'
      signal_to_digit[one] = '1'
      signal_to_digit[two] = '2'
      signal_to_digit[three] = '3'
      signal_to_digit[four] = '4'
      signal_to_digit[five] = '5'
      signal_to_digit[six] = '6'
      signal_to_digit[seven] = '7'
      signal_to_digit[eight] = '8'
      signal_to_digit[nine] = '9'

      signal_to_digit
    end

    private

    def find_and_remove!(signals, &block)
      s = signals.find(&block)
      signals.delete(s)
    end
  end

  attr_reader :displays

  def initialize(*)
    super

    @displays = input_lines.map do |input_line|
      code, output_values = input_line.split(' | ').map { |part| part.split(' ') }
      Display.new(code, output_values)
    end
  end

  def part_one_output
    displays.map(&:output_values).flatten.count { |value| [2, 3, 4, 7].include?(value.size) }
  end

  def part_two_output
    displays.map(&:numeric_value).sum
  end
end
