RSpec.describe Day3 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day3.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(157) }

    it "splits a rucksack into two compartments" do
      expect(day.split_rucksack("vJrwpWtwJgWrhcsFMMfFFhFp")).to eq([
        "vJrwpWtwJgWr",
        "hcsFMMfFFhFp"
      ])
    end

    it "finds duplicate item accross compartments" do
      input = [
        "vJrwpWtwJgWr",
        "hcsFMMfFFhFp"
      ]
      expected = "p"
      expect(day.find_duplicate(input)).to eq(expected)
    end

    it "calculates the priority of a given item" do
      inputs = ["p", "L", "P", "v", "t", "s", "r", "Z"]
      expected = [16, 38, 42, 22, 20, 19, 18, 52]
      inputs.each.with_index do |input, index|
        expect(day.priority(input)).to eq(expected[index])
      end
    end
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(70) }

    it "finds duplicate items in first example group" do
      first_rucksack = "vJrwpWtwJgWrhcsFMMfFFhFp"
      second_rucksack = "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"
      third_rucksack = "PmmdzqPrVvPwwTWBwg"
      duplicates = day.find_duplicates(first_rucksack, second_rucksack)
      badge = day.find_duplicates(duplicates, third_rucksack)

      expect(badge).to eq("r")
    end

    it "finds duplicate items in second example group" do
      first_rucksack = "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn"
      second_rucksack = "ttgJtRGJQctTZtZT"
      third_rucksack = "CrZsJsPPZsGzwwsLwLmpwMDw"
      duplicates = day.find_duplicates(first_rucksack, second_rucksack)
      badge = day.find_duplicates(duplicates, third_rucksack)

      expect(badge).to eq("Z")
    end
  end
end
