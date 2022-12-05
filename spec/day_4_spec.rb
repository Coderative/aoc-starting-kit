RSpec.describe Day4 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day4.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(2) }

    it "detects complete overlap for first elf" do
      elf1 = "2-8"
      elf2 = "3-7"
      expect(day.overlap?(elf1, elf2, total: true)).to be(true)
    end

    it "detects complete overlap for second elf" do
      elf1 = "6-6"
      elf2 = "4-6"
      expect(day.overlap?(elf1, elf2, total: true)).to be(true)
    end

    it "detects no overlap when there is no intersection" do
      elf1 = "1-2"
      elf2 = "3-4"
      expect(day.overlap?(elf1, elf2, total: true)).to be(false)
    end

    it "detects no overlap when there is a partial cover" do
      elf1 = "1-3"
      elf2 = "2-4"
      expect(day.overlap?(elf1, elf2, total: true)).to be(false)
    end

    it "detects no overlap with 2 digit numbers" do
      elf1 = "76-80"
      elf2 = "75-79"
      expect(day.overlap?(elf1, elf2, total: true)).to be(false)
    end

    it "detects overlap with 2 digit numbers" do
      elf1 = "55-66"
      elf2 = "55-65"
      expect(day.overlap?(elf1, elf2, total: true)).to be(true)
    end

    it "detects overlap when both assignments are identical" do
      elf1 = "7-49"
      elf2 = "7-49"
      expect(day.overlap?(elf1, elf2, total: true)).to be(true)
    end
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(4) }

    it "detects total overlap for first elf" do
      elf1 = "2-8"
      elf2 = "3-7"
      expect(day.overlap?(elf1, elf2, total: false)).to be(true)
    end

    it "detects total overlap for second elf" do
      elf1 = "6-6"
      elf2 = "4-6"
      expect(day.overlap?(elf1, elf2, total: false)).to be(true)
    end

    it "detects partial overlap of one section" do
      elf1 = "5-7"
      elf2 = "7-9"
      expect(day.overlap?(elf1, elf2, total: false)).to be(true)
    end

    it "detects partial overlap of three sections" do
      elf1 = "2-6"
      elf2 = "4-8"
      expect(day.overlap?(elf1, elf2, total: false)).to be(true)
    end
  end
end
