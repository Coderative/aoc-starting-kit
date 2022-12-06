class Day5 < AOC
  def solve(part:)
    initial, instruction = input_parts.values
    stacks = stacks(initial)
    instructions = instructions(instruction)
    move(stacks, instructions, part)
    stacks.values.map(&:first).join
  end

  def input_parts
    initial, _blank_line, instruction = read_input_file.slice_when { |first, second| [first, second].include?("") }.to_a
    {
      initial: initial,
      instruction: instruction
    }
  end

  def instructions(instruction)
    instruction
      .map do |move|
        /move (?<move>\d+) from (?<from>\d) to (?<to>\d)/
          .match(move)
          .named_captures
          .transform_keys(&:to_sym)
          .transform_values(&:to_i)
      end
  end

  def stacks(initial_position)
    stacks = initial_position[-1]
      .split
      .map { |number| [number.to_i, []] }
      .to_h

    initial_position[0..-2]
      .map { |line| (0..(stacks.size - 1)).map { |n| line[1 + 4 * n] }.join }
      .each do |line|
        line.chars.each.with_index { |char, index| stacks[index + 1].push(char) if char != " " }
      end
    stacks
  end

  def move(stacks, instructions, part = 1)
    instructions.each do |instruction|
      origin = stacks[instruction[:from]]
      crates = origin.shift(instruction[:move])
      destination = stacks[instruction[:to]]
      if part == 1
        destination.unshift(*crates.reverse)
      else
        destination.unshift(*crates)
      end
    end
    stacks
  end
end
