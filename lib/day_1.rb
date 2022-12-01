require_relative "./aoc"

class Day1 < AOC
  def solve(part:)
    data = lazy_load_data
    data = convert_strings_to_integers(data)
    data = break_list(data)
    data = count_calories(data)

    if part == 1
      find_max(data)
    else
      find_max_3(data).sum
    end
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

  def find_max(data)
    data.max
  end

  def find_max_3(data)
    data.max(3)
  end
end
