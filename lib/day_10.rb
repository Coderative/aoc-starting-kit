class Day10 < AOC
  CRT_WIDTH = 40
  CRT_HEIGHT = 6

  def solve(part:)
    commands = read_input_file
    values = execute_commands(1, commands)

    if part == 1
      values
        .select.with_index { |value, index| index % CRT_WIDTH == 19 }
        .map.with_index { |value, index| value * (20 + index * CRT_WIDTH) }
        .sum
    else
      pixels(values)[0..(CRT_WIDTH * CRT_HEIGHT - 1)]
        .each_slice(CRT_WIDTH)
        .map { |line| line.map { |drawable| drawable ? "#" : "." }.join }
        .join("\n")
    end
  end

  def parse_command(command)
    case command
    when /\Aaddx -?\d+\z/
      _, to_add = command.split(" ")
      {duration: 2, function: ->(number) { number + to_add.to_i }}
    else
      {duration: 1, function: ->(number) { number }}
    end
  end

  def execute_commands(initial_value, commands)
    commands.each_with_object([initial_value]) do |command, values|
      last_value = values.last
      parsed_command = parse_command(command)
      duration, function = parsed_command.values_at(:duration, :function)

      (1..duration).each.with_index do |_, index|
        values.tap do |values|
          command_ended = index == duration - 1
          values << (command_ended ? function.call(last_value) : last_value)
        end
      end
    end
  end

  def pixels(values)
    values.map.with_index { |value, index| is_drawable?(value, index) }
  end

  def is_drawable?(value, index)
    ((value - 1)..(value + 1)).cover?(index % CRT_WIDTH)
  end
end
