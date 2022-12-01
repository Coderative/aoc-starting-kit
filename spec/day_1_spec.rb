RSpec.describe Day1 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day1.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(7) }
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(5) }
  end
end
