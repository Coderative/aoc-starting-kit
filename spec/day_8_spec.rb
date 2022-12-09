RSpec.describe Day8 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day8.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(21) }

    it "counts visible trees on the edge" do
      input = [
        [2, 3],
        [0, 9]
      ]
      expected = 4
      expect(day.count_on_edge(input)).to eq(expected)
    end

    it "counts visible trees on the edge for a 3x3 grid" do
      input = [
        [2, 3, 3],
        [7, 2, 3],
        [1, 5, 2]
      ]
      expected = 8
      expect(day.count_on_edge(input)).to eq(expected)
    end

    it "counts visible trees on the edge for a 5x3 grid" do
      input = [
        [2, 3, 3, 2, 4],
        [7, 2, 3, 2, 4],
        [1, 5, 2, 2, 4]
      ]
      expected = 12
      expect(day.count_on_edge(input)).to eq(expected)
    end

    it "counts visible tree in the center with a shorter tree" do
      input = [
        [2, 3, 3],
        [7, 2, 3],
        [1, 5, 2]
      ]
      expected = 0
      expect(day.count_in_center(input)).to eq(expected)
    end

    it "counts visible tree in the center with a shorter tree" do
      input = [
        [2, 3, 3],
        [7, 9, 3],
        [1, 5, 2]
      ]
      expected = 1
      expect(day.count_in_center(input)).to eq(expected)
    end

    it "counts visible tree in the center with a shorter tree" do
      input = [
        [8, 8, 8, 8, 8],
        [8, 4, 4, 4, 8],
        [8, 4, 6, 4, 8],
        [8, 4, 4, 4, 8],
        [8, 8, 8, 8, 8]
      ]
      expected = 0
      expect(day.count_in_center(input)).to eq(expected)
    end
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(8) }

    it "calculates scenic score for one tree" do
      input = [
        [2, 3, 3],
        [7, 2, 3],
        [1, 5, 2]
      ]
      expected = [1]
      expect(day.scenic_scores(input)).to eq(expected)
    end

    it "calculates scenic score for one tree" do
      input = [
        [8, 8, 8, 8, 8],
        [8, 4, 4, 4, 8],
        [8, 4, 6, 4, 8],
        [8, 4, 4, 4, 8],
        [8, 8, 8, 8, 8]
      ]
      expected = [1, 1, 1, 1, 16, 1, 1, 1, 1]
      expect(day.scenic_scores(input)).to eq(expected)
    end

    it "calculates scenic score for example" do
      input = [
        [3, 0, 3, 7, 3],
        [2, 5, 5, 1, 2],
        [6, 5, 3, 3, 2],
        [3, 3, 5, 4, 9],
        [3, 5, 3, 9, 0]
      ]
      expected = [1, 4, 1, 6, 1, 2, 1, 8, 3]
      expect(day.scenic_scores(input)).to eq(expected)
    end
  end
end
