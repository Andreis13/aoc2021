
require_relative '../base_solution'

class Solution < BaseSolution
  attr_reader :called_numbers, :boards

  class Board
    attr_reader :numbers, :marked_rows, :marked_columns

    def initialize(numbers)
      @numbers = numbers
      @marked_rows = Array.new(5) { 0 }
      @marked_columns = Array.new(5) { 0 }
    end

    def mark(called_number)
      numbers.each_with_index do |row, i|
        row.each_with_index do |number, j|
          if called_number == number
            marked_rows[i] += 1
            marked_columns[j] += 1
            row[j] = nil
            return
          end
        end
      end
    end

    def winning?
      marked_rows.any? { |row| row == 5 } || marked_columns.any? { |col| col == 5 }
    end

    def unmarked_sum
      numbers.flatten.compact.sum
    end
  end

  def initialize(*)
    super

    data = input_lines
      .map(&:chomp)
      .slice_after { |line| line.empty? }
      .map { |line_batch| line_batch.reject(&:empty?) }

    @called_numbers = data.shift.first.split(',').map(&:to_i)
    @boards = data.map { |board_data| Board.new(board_data.map { |board_line| board_line.split(' ').map(&:to_i) }) }
  end

  def part_one_output
    called_numbers.each do |number|
      boards.each do |board|
        board.mark(number)

        if board.winning?
          return board.unmarked_sum * number
        end
      end
    end
  end

  def part_two_output
    winning_boards = []

    called_numbers.each do |number|
      boards.each do |board|
        next if board.winning?

        board.mark(number)

        if board.winning?
          winning_boards << [board, number]
        end
      end
    end

    board, number = winning_boards.last
    board.unmarked_sum * number
  end
end
