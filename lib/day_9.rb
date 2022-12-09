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
    initial_knot = {x: 0, y: 0}
    rope_length = (part == 1) ? 2 : 10
    rope = Array.new(rope_length, initial_knot)

    read_input_file
      .then { |input| build_movements(input) }
      .then { |movements| make_moves([rope], movements) }
      .then { |ropes| ropes.map(&:last).uniq.size }
  end

  def make_moves(ropes, movements)
    if movements == []
      ropes
    else
      do_make_move(ropes, movements)
    end
  end

  def build_movements(instructions)
    instructions.flat_map do |instruction|
      direction, steps = instruction.split(" ")
      (1..steps.to_i).map { DIRECTIONS_MAPPING[direction] }
    end
  end

  def move_tail(new_head, tail)
    tail.dup.tap { |new_tail| move_tail!(new_head, new_tail) }
  end

  private

  def do_make_move(ropes, movements)
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

  def move_tail!(head, tail)
    delta_x = head[:x] - tail[:x]
    delta_y = head[:y] - tail[:y]

    case [delta_x.abs, delta_y.abs]
    in [0, 0] | [1, 0] | [0, 1] | [1, 1]
      tail
    in [0, 2]
      move_closer!(tail, head, :y)
    in [2, 0]
      move_closer!(tail, head, :x)
    in _
      move_closer!(tail, head, :x)
      move_closer!(tail, head, :y)
    end
  end

  def move_closer!(tail, head, direction)
    tail[direction] += head[direction] <=> tail[direction]
  end
end
