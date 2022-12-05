class Day4 < AOC
  def solve(part:)
    read_input_file
      .map { |pair| pair.split(",") }
      .map { |(elf1, elf2)| overlap?(elf1, elf2, total: part == 1) }
      .count(true)
  end

  def overlap?(elf1, elf2, total:)
    range_1 = to_range(elf1)
    range_2 = to_range(elf2)
    return (range_1.cover?(range_2) || range_2.cover?(range_1)) if total

    overlap_1 = range_1.map { |section_1| range_2.cover?(section_1) }
    overlap_2 = range_2.map { |section_2| range_1.cover?(section_2) }
    (overlap_1 + overlap_2).any?
  end

  private

  def to_range(elf)
    first_section, last_section = elf.split("-").map(&:to_i)
    first_section..last_section
  end
end
