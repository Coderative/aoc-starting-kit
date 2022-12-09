class Day9 < AOC
  STEPS = {
    left: {attribute: :x, amount: -1},
    right: {attribute: :x, amount: 1},
    up: {attribute: :y, amount: 1},
    down: {attribute: :y, amount: -1}
  }
  DIRECTIONS_MAPPING = {
    "U" => :up,
    "D" => :down,
    "L" => :left,
    "R" => :right
  }

  def solve(part:)
    initial = {x: 0, y: 0}
    range = (part == 1) ? 1..2 : 1..10
    knots = range.map { initial.dup }
    input = read_input_file
    movements = build_movements(input)
    positions = make_moves(knots, movements)
    positions.map { |knots| knots[-1] }.uniq.size
  end

  def make_moves(initial_knots, movements)
    do_make_moves([initial_knots], movements)
  end

  def do_make_moves(positions, movements)
    if movements == []
      positions
    else
      movement, *remaining_movements = movements
      knots = positions[-1]
      head = knots[0]
      new_head = head.dup
      new_head[STEPS[movement][:attribute]] += STEPS[movement][:amount]

      new_knots = knots[0..-2].zip(knots[1..]).reduce([new_head]) do |new_knots, (knot_1, knot_2)|
        new_knot_1 = new_knots[-1]
        new_knot_2 = move_tail(knot_1, new_knot_1, knot_2)
        new_knots << new_knot_2
      end
      do_make_moves(positions << new_knots, remaining_movements)
    end
  end

  def build_movements(instructions)
    instructions.flat_map do |instruction|
      direction, steps = instruction.split(" ")
      (1..steps.to_i).map { DIRECTIONS_MAPPING[direction] }
    end
  end

  def move_tail(head, new_head, tail)
    new_tail = tail.dup

    return new_tail if are_adjacent?(new_head, new_tail)
    delta_x = delta_x(new_head, new_tail)
    delta_y = delta_y(new_head, new_tail)
    case delta_x.abs + delta_y.abs
    when 0..1
      new_tail
    when 2
      case delta_x.abs
      when 0
        new_tail[:y] += new_head[:y] <=> new_tail[:y]
      when 1
        new_tail
      else
        new_tail[:x] += new_head[:x] <=> new_tail[:x]
      end
    when (3..)
      new_tail[:x] += new_head[:x] <=> new_tail[:x]
      new_tail[:y] += new_head[:y] <=> new_tail[:y]
    end

    new_tail
  end

  private

  def are_adjacent?(head, tail)
    delta_x(head, tail).abs <= 1 && delta_y(head, tail).abs <= 1
  end

  def delta_x(head, tail)
    head[:x] - tail[:x]
  end

  def delta_y(head, tail)
    head[:y] - tail[:y]
  end
end
