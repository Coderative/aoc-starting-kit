class AOC
  def initialize(input_file:)
    @input_file = input_file
  end

  def read_input_file
    IO.read(@input_file).split("\n")
  end

  def convert_list_of_string_into_list_of_integers(list)
    list.map(&:to_i)
  end

  def break_list_on(data, divider)
    data
      .chunk_while { |first, second| first !=  divider && second != divider }
      .filter { |group| group != [divider] }
  end

  def sums_on_sublists(data)
    data.map(&:sum)
  end
end
