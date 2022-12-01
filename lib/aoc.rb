class AOC
  def initialize(input_file:)
    @input_file = input_file
  end

  def read_input_file
    IO.read(@input_file).split("\n")
  end
end
