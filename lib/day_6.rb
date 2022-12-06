class Day6 < AOC
  def solve(part:)
    offset = (part == 1) ? 4 : 14
    read_input_file
      .first
      .chars
      .each_cons(offset)
      .map(&:join)
      .map { |potential_marker| is_marker?(potential_marker) }
      .find_index(true) + offset
  end

  def is_marker?(potential_marker)
    potential_marker.chars.uniq.join("") == potential_marker
  end
end
