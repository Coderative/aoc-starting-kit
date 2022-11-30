class AOC
  def initialize(input_file:)
    @input_file = input_file
  end

  def lazy_load_data
    IO.foreach(@input_file).lazy
  end
end
