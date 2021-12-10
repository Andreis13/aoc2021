
require_relative '../base_solution'

class Solution < BaseSolution
  ERROR_SCORE = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  AUTOCOMPLETE_SCORE = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }

  DELIMITERS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">",
  }

  class ChunkValidator
    attr_reader :string, :stack, :unexpected_char

    def initialize(string)
      @string = string
    end

    def run
      @stack = []

      string.each_char do |char|
        if DELIMITERS.keys.include?(char)
          stack << char
        elsif DELIMITERS[stack.last] == char
          stack.pop
        elsif stack.any?
          @unexpected_char = char
          return
        end
      end
    end

    def error?
      !!unexpected_char
    end

    def incomplete?
      !error? && stack.any?
    end

    def auto_complete_chars
      stack.reverse.map { |c| DELIMITERS[c] }
    end
  end

  def part_one_output
    validators = unexpected_chars = input_lines.map do |line|
      ChunkValidator.new(line.chomp)
    end

    validators.each(&:run)

    validators.select(&:error?).sum do |v|
      ERROR_SCORE[v.unexpected_char]
    end
  end

  def part_two_output
    validators = unexpected_chars = input_lines.map do |line|
      ChunkValidator.new(line.chomp)
    end

    validators.each(&:run)

    scores = validators.select(&:incomplete?).map do |v|
      v.auto_complete_chars.inject(0) { |acc, c| acc * 5 + AUTOCOMPLETE_SCORE[c] }
    end

    scores.sort[(scores.size / 2.0).floor]
  end
end
