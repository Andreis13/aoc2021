class BaseSolution
  attr_reader :input_lines, :input_data

  def initialize(input_file_path)
    @input_data = File.read(input_file_path)
    @input_lines = @input_data.lines
  end

  def part_one_output
    raise NotImplementedError
  end

  def part_two_output
    raise NotImplementedError
  end
end
