
require_relative '../base_solution'

class Solution < BaseSolution
  def part_one_output
    one_counts = Array.new(input_lines.first.chomp.size) { 0 }
    line_half_count = input_lines.size / 2

    input_lines.each do |line|
      bits = line.chomp.split('')
      bits.each_with_index do |bit, i|
        if bit == '1'
          one_counts[i] += 1
        end
      end
    end

    gamma = one_counts.map { |c| c > line_half_count ? '1' : '0' }.join.to_i(2)
    epsilon = one_counts.map { |c| c > line_half_count ? '0' : '1' }.join.to_i(2)

    gamma * epsilon
  end

  def part_two_output
    numbers = input_lines.map do |line|
      line.chomp.split('').map(&:to_i)
    end

    oxygen_ratings = co2_ratings = numbers

    numbers.first.size.times do |i|
      oxygen_ratings = filter_by_most_common_bit(oxygen_ratings, i)
    end

    numbers.first.size.times do |i|
      co2_ratings = filter_by_least_common_bit(co2_ratings, i)
    end


    to_dec_number(oxygen_ratings.first) * to_dec_number(co2_ratings.first)
  end

  def to_dec_number(bit_array)
    bit_array.map(&:to_s).join.to_i(2)
  end

  def filter_by_most_common_bit(numbers, i)
    grouped_numbers = numbers.group_by { |bits| bits[i] }
    if grouped_numbers[1]&.size.to_i >= grouped_numbers[0]&.size.to_i
      grouped_numbers[1]
    else
      grouped_numbers[0]
    end
  end

  def filter_by_least_common_bit(numbers, i)
    grouped_numbers = numbers.group_by { |bits| bits[i] }
    if grouped_numbers[0]&.size.to_i <= grouped_numbers[1]&.size.to_i
      grouped_numbers[0] || grouped_numbers[1]
    else
      grouped_numbers[1] || grouped_numbers[0]
    end
  end
end
