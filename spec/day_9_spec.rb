RSpec.describe Day9 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day9.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(13) }

    it "moves H to the left once" do
      rope = [{x: 0, y: 0}, {x: -1, y: 0}]
      movements = [:left]
      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [{x: 0, y: 0}, {x: -1, y: 0}],
        [{x: -1, y: 0}, {x: -1, y: 0}]
      ])
    end

    it "moves H to the left twice" do
      rope = [{x: 0, y: 0} , {x: -1, y: 0}]
      movements = [:left, :left]
      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [{x: 0, y: 0}, {x: -1, y: 0}],
        [{x: -1, y: 0}, {x: -1, y: 0}],
        [{x: -2, y: 0}, {x: -1, y: 0}]
      ])
    end

    it "moves H to the right once" do
      rope = [{x: 0, y: 0}, {x: -1, y: 0}]
      movements = [:right]
      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [{x: 0, y: 0}, {x: -1, y: 0}],
        [{x: 1, y: 0}, {x: 0, y: 0}]
      ])
    end

    it "moves H to up once" do
      rope = [{x: 0, y: 0}, {x: -1, y: 0}]
      movements = [:up]
      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [{x: 0, y: 0}, {x: -1, y: 0}],
        [{x: 0, y: 1}, {x: -1, y: 0}]
      ])
    end

    it "moves H down once" do
      rope = [{x: 0, y: 0}, {x: -1, y: 0}]
      movements = [:down]
      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [{x: 0, y: 0}, {x: -1, y: 0}],
        [{x: 0, y: -1}, {x: -1, y: 0}]
      ])
    end

    it "converts text instruction into movements" do
      input = [
        "R 4",
        "U 4",
        "L 3",
        "D 1"
      ]
      movements = [:right, :right, :right, :right, :up, :up, :up, :up, :left, :left, :left, :down]

      expect(day.build_movements(input)).to eq(movements)
    end

    it "tracks H movement" do
      input = day.read_input_file
      movements = day.build_movements(input)
      rope = [{x: 0, y: 0}, {x: 0, y: 0}]
      ropes = day.make_moves([rope], movements)
      final_head = ropes[-1][0]
      expect(final_head).to eq({x: 2, y: 2})
    end

    it "moves T to the right once" do
      tail = {x: -1, y: 0}
      new_head = {x: 1, y: 0}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 0})
      expect(tail).to eq({x: -1, y: 0})
    end

    it "moves T left once" do
      tail = {x: 1, y: 0}
      new_head = {x: -1, y: 0}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 0})
    end

    it "moves T down once" do
      tail = {x: 0, y: 1}
      new_head = {x: 0, y: -1}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 0})
    end

    it "moves T up once" do
      tail = {x: 0, y: -1}
      new_head = {x: 0, y: 1}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 0})
    end

    it "does not move T when H overlaps" do
      tail = {x: -1, y: 0}
      new_head = {x: -1, y: 0}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: -1, y: 0})
    end

    it "does not move T when H is still adjacent" do
      tail = {x: -1, y: 0}
      new_head = {x: 0, y: 1}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: -1, y: 0})
    end

    it "moves T up and to the right" do
      tail = {x: -1, y: -1}
      new_head = {x: 0, y: 1}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 0})
    end

    it "moves T up and to the left" do
      tail = {x: 1, y: -1}
      new_head = {x: 0, y: 1}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 0})
    end

    it "moves T to a diagonal" do
      tail = {x: 3, y: 0}
      new_head = {x: 5, y: 1}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 4, y: 1})
    end

    it "does not move T to another diagonal" do
      tail = {x: 0, y: 0}
      new_head = {x: 0, y: 2}
      new_tail = day.move_tail(new_head, tail)
      expect(new_tail).to eq({x: 0, y: 1})
    end

    it "tracks T movement" do
      input = day.read_input_file
      movements = day.build_movements(input)
      rope = [{x: 0, y: 0}, {x: 0, y: 0}]
      ropes = day.make_moves([rope], movements)
      final_tail = ropes[-1][-1]
      expect(final_tail).to eq({x: 1, y: 2})
    end
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(1) }

    it "tracks T movement" do
      rope = [
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0}
      ]
      movements = [:up, :up, :up, :up]

      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [{x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: 0}],
        [{x: 0, y: 1}, {x: 0, y: 0}, {x: 0, y: 0}],
        [{x: 0, y: 2}, {x: 0, y: 1}, {x: 0, y: 0}],
        [{x: 0, y: 3}, {x: 0, y: 2}, {x: 0, y: 1}],
        [{x: 0, y: 4}, {x: 0, y: 3}, {x: 0, y: 2}]
      ])
    end

    it "tracks T movement" do
      input = day.read_input_file
      movements = day.build_movements(input)
      rope = [
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0},
        {x: 0, y: 0}
      ]

      ropes = day.make_moves([rope], movements)
      final_rope = ropes[-1]
      final_head = final_rope[0]
      final_knot_1 = final_rope[1]
      final_tail = final_rope[-1]
      expect(final_head).to eq({x: 2, y: 2})
      expect(final_knot_1).to eq({x: 1, y: 2})
      expect(final_tail).to eq({x: 0, y: 0})
    end
  end
  context "part two input b" do
    let(:part) { 2 }
    let(:input_file) { "spec/fixtures/day9b.txt" }
    it { is_expected.to eq(36) }

    it "moves mid knots when moving up" do
      rope = [
        {x: 5, y: 0},
        {x: 4, y: 0},
        {x: 3, y: 0},
        {x: 2, y: 0}
      ]
      movements = [:up, :up]
      ropes = day.make_moves([rope], movements)
      expect(ropes).to eq([
        [
          {x: 5, y: 0},
          {x: 4, y: 0},
          {x: 3, y: 0},
          {x: 2, y: 0}
        ], [
          {x: 5, y: 1},
          {x: 4, y: 0},
          {x: 3, y: 0},
          {x: 2, y: 0}
        ], [
          {x: 5, y: 2},
          {x: 5, y: 1},
          {x: 4, y: 1},
          {x: 3, y: 1}
        ]
      ])
    end

    it "moves mid knots when moving left" do
      rope = [
        {x: 5, y: 8},
        {x: 5, y: 7},
        {x: 5, y: 6},
        {x: 5, y: 5},
        {x: 5, y: 4},
        {x: 4, y: 4},
        {x: 3, y: 3},
        {x: 2, y: 2},
        {x: 1, y: 1},
        {x: 0, y: 0}
      ]
      movements = [:left, :left, :left, :left, :left, :left, :left, :left]
      ropes = day.make_moves([rope], movements)
      expect(ropes[-1]).to eq([
        {x: -3, y: 8},
        {x: -2, y: 8},
        {x: -1, y: 8},
        {x: 0, y: 8},
        {x: 1, y: 8},
        {x: 1, y: 7},
        {x: 1, y: 6},
        {x: 1, y: 5},
        {x: 1, y: 4},
        {x: 1, y: 3}
      ])
    end
  end
end
