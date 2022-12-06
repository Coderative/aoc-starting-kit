RSpec.describe Day5 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day5.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq("CMZ") }

    it "splits the input into 2 parts" do
      initial = [
        "    [D]    ",
        "[N] [C]    ",
        "[Z] [M] [P]",
        " 1   2   3 "
      ]
      instruction = [
        "move 1 from 2 to 1",
        "move 3 from 1 to 3",
        "move 2 from 2 to 1",
        "move 1 from 1 to 2"
      ]

      expect(day.input_parts).to eq({
        initial: initial,
        instruction: instruction
      })
    end

    it "parses instructions" do
      instruction = [
        "move 1 from 2 to 1",
        "move 3 from 1 to 3",
        "move 2 from 2 to 1",
        "move 1 from 1 to 2"
      ]
      expected = [
        {move: 1, from: 2, to: 1},
        {move: 3, from: 1, to: 3},
        {move: 2, from: 2, to: 1},
        {move: 1, from: 1, to: 2}
      ]

      expect(day.instructions(instruction)).to eq(expected)
    end

    it "parses the initial position" do
      initial = [
        "    [D]    ",
        "[N] [C]    ",
        "[Z] [M] [P]",
        " 1   2   3 "
      ]
      expected = {
        1 => ["N", "Z"],
        2 => ["D", "C", "M"],
        3 => ["P"]
      }
      expect(day.stacks(initial)).to eq(expected)
    end

    it "moves one crate" do
      stacks = {
        1 => ["N", "Z"],
        2 => ["D", "C", "M"],
        3 => ["P"]
      }
      instructions = [
        {move: 1, from: 2, to: 1}
      ]
      expected = {
        1 => ["D", "N", "Z"],
        2 => ["C", "M"],
        3 => ["P"]
      }
      expect(day.move(stacks, instructions)).to eq(expected)
    end

    it "moves three crates" do
      stacks = {
        1 => ["D", "N", "Z"],
        2 => ["C", "M"],
        3 => ["P"]
      }
      instructions = [
        {move: 3, from: 1, to: 3}
      ]
      expected = {
        1 => [],
        2 => ["C", "M"],
        3 => ["Z", "N", "D", "P"]
      }
      expect(day.move(stacks, instructions)).to eq(expected)
    end

    it "moves two crates" do
      stacks = {
        1 => [],
        2 => ["C", "M"],
        3 => ["Z", "N", "D", "P"]
      }
      instructions = [
        {move: 2, from: 2, to: 1}
      ]
      expected = {
        1 => ["M", "C"],
        2 => [],
        3 => ["Z", "N", "D", "P"]
      }
      expect(day.move(stacks, instructions)).to eq(expected)
    end

    it "moves two crates" do
      stacks = {
        1 => ["M", "C"],
        2 => [],
        3 => ["Z", "N", "D", "P"]
      }
      instructions = [
        {move: 1, from: 1, to: 2}
      ]
      expected = {
        1 => ["C"],
        2 => ["M"],
        3 => ["Z", "N", "D", "P"]
      }
      expect(day.move(stacks, instructions)).to eq(expected)
    end
  end

  context "part two" do
    let(:part) { 2 }

    it { is_expected.to eq("MCD") }

    it "moves one crate" do
      stacks = {
        1 => ["N", "Z"],
        2 => ["D", "C", "M"],
        3 => ["P"]
      }
      instructions = [
        {move: 1, from: 2, to: 1}
      ]
      expected = {
        1 => ["D", "N", "Z"],
        2 => ["C", "M"],
        3 => ["P"]
      }
      expect(day.move(stacks, instructions, part)).to eq(expected)
    end

    it "moves three crates" do
      stacks = {
        1 => ["D", "N", "Z"],
        2 => ["C", "M"],
        3 => ["P"]
      }
      instructions = [
        {move: 3, from: 1, to: 3}
      ]
      expected = {
        1 => [],
        2 => ["C", "M"],
        3 => ["D", "N", "Z", "P"]
      }
      expect(day.move(stacks, instructions, part)).to eq(expected)
    end

    it "moves two crates" do
      stacks = {
        1 => [],
        2 => ["C", "M"],
        3 => ["D", "N", "Z", "P"]
      }
      instructions = [
        {move: 2, from: 2, to: 1}
      ]
      expected = {
        1 => ["C", "M"],
        2 => [],
        3 => ["D", "N", "Z", "P"]
      }
      expect(day.move(stacks, instructions, part)).to eq(expected)
    end

    it "moves two crates" do
      stacks = {
        1 => ["C", "M"],
        2 => [],
        3 => ["Z", "N", "D", "P"]
      }
      instructions = [
        {move: 1, from: 1, to: 2}
      ]
      expected = {
        1 => ["M"],
        2 => ["C"],
        3 => ["Z", "N", "D", "P"]
      }
      expect(day.move(stacks, instructions, part)).to eq(expected)
    end
  end
end
