class Day3 < AOC
  def solve(part:)
    if part == 1
      read_input_file.reduce(0) do |total_priority, rucksack|
        compartments = split_rucksack(rucksack)
        duplicate = find_duplicate(compartments)
        total_priority + priority(duplicate)
      end
    else
      read_input_file.each_slice(3).reduce(0) do |total_priority, group|
        duplicates = find_duplicates(group[0], group[1])
        badge = find_duplicates(duplicates, group[2])
        total_priority + priority(badge)
      end
    end
  end

  def split_rucksack(rucksack)
    compartment_size = rucksack.size / 2
    [
      rucksack[0..(compartment_size - 1)],
      rucksack[compartment_size..]
    ]
  end

  def find_duplicate(compartments)
    first, second = compartments
    first.chars.find { |item| second.chars.include?(item) }
  end

  def priority(item)
    priorities_one = ("a".."z").map.with_index { |item, index| [item, index + 1] }.to_h
    priorities_two = ("A".."Z").map.with_index { |item, index| [item, index + 27] }.to_h
    priorities = priorities_one.merge(priorities_two)
    priorities[item]
  end

  def find_duplicates(first_rucksack, second_rucksack)
    first_rucksack
      .chars
      .select { |item| second_rucksack.chars.include?(item) }
      .uniq
      .join
  end
end
