require "day_1"

RSpec.describe Day1 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day1.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(24000) }

    it "converts a list of strings into a list of integers" do
      data = ["1000", "2000", "3000", "", "4000"]
      expected = [1000, 2000, 3000, 0, 4000]
      expect(day.convert_strings_to_integers(data)).to eq(expected)
    end

    it "breaks apart the list on 0" do
      data = [1000, 2000, 3000, 0, 4000]
      expected = [
        [1000, 2000, 3000],
        [4000]
      ]
      expect(day.break_list(data)).to eq(expected)
    end

    it "counts the calories per elf" do
      data = [
        [1000, 2000, 3000],
        [4000]
      ]
      expected = [6000, 4000]
      expect(day.count_calories(data)).to eq(expected)
    end

    it "finds the maximum" do
      data = [6000, 4000]
      expected = 6000
      expect(day.find_max(data)).to eq(expected)
    end
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(45000) }

    it "finds the 3 biggest numbers" do
      data = [6000, 4000, 2000, 5000, 10000]
      expected = [10000, 6000, 5000]
      expect(day.find_max_3(data)).to eq(expected)
    end
  end
end
