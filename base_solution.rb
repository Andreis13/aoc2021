class BaseSolution
  attr_reader :input_lines

  def initialize(input_file_path)
    @input_lines = File.read(input_file_path).lines
  end

  def part_one_output
    raise NotImplementedError
  end

  def part_two_output
    raise NotImplementedError
  end
end
