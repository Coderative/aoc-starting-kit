require_relative "./aoc"

class Day1 < AOC
  def solve(part:)
    read_input_file
      .map(&:to_i)
      .then(&method(:convert_strings_to_integers))
      .then(&method(:break_list))
      .then(&method(:count_calories))
      .then { |data| part == 1 ? data.max : data.max(3).sum  }
  end

  def convert_strings_to_integers(data)
    data.map(&:to_i)
  end

  def break_list(data)
    data
      .chunk_while { |first, second| first !=  0 && second != 0 }
      .filter { |elf| elf != [0] }
      .to_a
  end

  def count_calories(data)
    data.map(&:sum)
  end
end
