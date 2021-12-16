
require_relative '../base_solution'

class Solution < BaseSolution
  HEX_TO_BIN = {
    '0' => '0000',
    '1' => '0001',
    '2' => '0010',
    '3' => '0011',
    '4' => '0100',
    '5' => '0101',
    '6' => '0110',
    '7' => '0111',
    '8' => '1000',
    '9' => '1001',
    'A' => '1010',
    'B' => '1011',
    'C' => '1100',
    'D' => '1101',
    'E' => '1110',
    'F' => '1111'
  }

  class NumberPacket
    attr_reader :version, :type, :value
    def initialize(version, type, value)
      @version = version
      @type = type
      @value = value
    end

    def version_sum
      version
    end

    def inspect
      "NumberPacket(v: #{version}, t: #{type}, num: #{value})"
    end
  end

  class OperatorPacket
    attr_reader :version, :type, :subpackets
    def initialize(version, type, subpackets)
      @version = version
      @type = type
      @subpackets = subpackets
    end

    def version_sum
      version + subpackets.sum(&:version_sum)
    end

    def inspect
      "OperatorPacket(v: #{version}, t: #{type}, subpackets: #{subpackets})"
    end

    def value
      sub_values = subpackets.map(&:value)
      case type
      when 0 # sum
        sub_values.sum
      when 1 # product
        sub_values.inject(&:*)
      when 2 # min
        sub_values.min
      when 3 # max
        sub_values.max
      when 5 # gt
        a, b = sub_values
        a > b ? 1 : 0
      when 6 # lt
        a, b = sub_values
        a < b ? 1 : 0
      when 7 # eq
        a, b = sub_values
        a == b ? 1 : 0
      end
    end
  end

  attr_reader :bin_string

  def initialize(*)
    super

    @bin_string = input_data.chomp.each_char.map { |c| HEX_TO_BIN[c] }.join
  end

  def part_one_output
    packet, remainder = parse_packet(bin_string)

    packet.version_sum
  end

  def part_two_output
    packet, remainder = parse_packet(bin_string)

    packet.value
  end

  def parse_packet(bits)
    version = bits[0, 3].to_i(2)
    type = bits[3, 3].to_i(2)

    if type == 4 # packet is number
      number, remainder = parse_number(bits[6..])
      [NumberPacket.new(version, type, number), remainder]
    else
      length_type = bits[6, 1].to_i(2)

      if length_type == 0
        sub_packets_length = bits[7, 15].to_i(2)

        sub_packets_payload = bits[22, sub_packets_length]

        sub_packets = []
        until sub_packets_payload.empty?
          packet, sub_packets_payload = parse_packet(sub_packets_payload)
          sub_packets << packet
        end

        [OperatorPacket.new(version, type, sub_packets), bits[(22 + sub_packets_length)..]]
      else
        number_of_sub_packets = bits[7, 11].to_i(2)

        sub_packets = []
        remainder = bits[18..]
        number_of_sub_packets.times do |i|
          packet, remainder = parse_packet(remainder)
          sub_packets << packet
        end

        [OperatorPacket.new(version, type, sub_packets), remainder]
      end
    end
  end

  def parse_number(bits)
    number_payload = []
    cursor = 0
    loop do
      slice = bits[cursor, 5]
      number_payload << slice[1..]
      cursor += 5
      break if slice[0] == '0'
    end
    [number_payload.join.to_i(2), bits[cursor..]]
  end
end
