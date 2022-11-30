require_relative "./aoc"

class Day1 < AOC
  def solve(part:)
    data = lazy_load_data.map(&:to_i)
    if part == 1
      count(data)
    else
      data
        .each_cons(3)
        .map(&:sum)
        .then { |data| count(data) }
    end
  end

  def count(data)
    data
      .each_cons(2)
      .filter { |source, target|  source < target}
      .force
      .length
  end
end
