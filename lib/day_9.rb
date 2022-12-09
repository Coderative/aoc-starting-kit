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
    rope = range.map { initial.dup }
    input = read_input_file
    movements = build_movements(input)
    ropes = make_moves([rope], movements)
    ropes.map { |rope| rope[-1] }.uniq.size
  end

  def make_moves(ropes, movements)
    if movements == []
      ropes
    else
      movement, *remaining_movements = movements
      last_rope = ropes[-1]
      head = last_rope[0]
      new_head = head.dup
      new_head[STEPS[movement][:attribute]] += STEPS[movement][:amount]

      new_rope = last_rope[1..].reduce([new_head]) do |knots, knot|
        current_head = knots[-1]
        new_knot = move_tail(current_head, knot)
        knots << new_knot
      end
      make_moves(ropes << new_rope, remaining_movements)
    end
  end

  def build_movements(instructions)
    instructions.flat_map do |instruction|
      direction, steps = instruction.split(" ")
      (1..steps.to_i).map { DIRECTIONS_MAPPING[direction] }
    end
  end

  def move_tail(new_head, tail)
    new_tail = tail.dup

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
