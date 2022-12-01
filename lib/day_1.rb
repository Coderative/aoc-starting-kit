require_relative "./aoc"

class Day1 < AOC
  def solve(part:)
    read_input_file
      .then { |data| convert_list_of_string_into_list_of_integers(data) }
      .then { |data| break_list_on(data, 0) }
      .then { |data| sums_on_sublists(data) }
      .then { |data| part == 1 ? data.max : data.max(3).sum  }
  end
end
