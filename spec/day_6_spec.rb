RSpec.describe Day6 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day6.txt" }
  let(:part) { 1 }

  context "part one with first example" do
    it { is_expected.to eq(7) }

    it "identifies a marker" do
      input = "abcd"
      expect(day.is_marker?(input)).to be(true)
    end

    it "does not identify a marker" do
      input = "abca"
      expect(day.is_marker?(input)).to be(false)
    end
  end

  context "part one with second example" do
    let(:input_file) { "spec/fixtures/day6a.txt" }
    it { is_expected.to eq(5) }
  end

  context "part one with third example" do
    let(:input_file) { "spec/fixtures/day6b.txt" }
    it { is_expected.to eq(6) }
  end

  context "part one with fourth example" do
    let(:input_file) { "spec/fixtures/day6c.txt" }
    it { is_expected.to eq(10) }
  end

  context "part one with fifth example" do
    let(:input_file) { "spec/fixtures/day6d.txt" }
    it { is_expected.to eq(11) }
  end

  context "part two" do
    let(:part) { 2 }

    it { is_expected.to eq(19) }

    it "identifies a marker" do
      input = "abcdefghijklmn"
      expect(day.is_marker?(input)).to be(true)
    end

    it "does not identify a marker" do
      input = "abcdefghijklma"
      expect(day.is_marker?(input)).to be(false)
    end
  end

  context "part two with second example" do
    let(:part) { 2 }
    let(:input_file) { "spec/fixtures/day6a.txt" }
    it { is_expected.to eq(23) }
  end

  context "part two with third example" do
    let(:part) { 2 }
    let(:input_file) { "spec/fixtures/day6b.txt" }
    it { is_expected.to eq(23) }
  end

  context "part two with fourth example" do
    let(:part) { 2 }
    let(:input_file) { "spec/fixtures/day6c.txt" }
    it { is_expected.to eq(29) }
  end

  context "part two with fifth example" do
    let(:part) { 2 }
    let(:input_file) { "spec/fixtures/day6d.txt" }
    it { is_expected.to eq(26) }
  end
end
