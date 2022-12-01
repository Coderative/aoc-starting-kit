RSpec.describe AOC do
  subject(:day) { described_class.new(input_file: double()) }

  describe "#convert_list_of_string_into_list_of_integers" do
    it "converts a list of strings into a list of integers" do
      data = ["1000", "2000", "3000", "", "4000"]
      expected = [1000, 2000, 3000, 0, 4000]
      expect(day.convert_list_of_string_into_list_of_integers(data)).to eq(expected)
    end
  end

  describe "#break_list_on" do
    it "breaks apart the list on 0" do
      data = [1000, 2000, 3000, 0, 4000]
      expected = [
        [1000, 2000, 3000],
        [4000]
      ]
      expect(day.break_list_on(data, 0)).to eq(expected)
    end

    it "breaks apart the list on 2000 " do
      data = [1000, 2000, 3000, 2000, 4000]
      expected = [
        [1000],
        [3000],
        [4000]
      ]
      expect(day.break_list_on(data, 2000)).to eq(expected)
    end
  end

  describe "#sums_on_sublists" do
    it "adds each sublist elements" do
      data = [
        [1000, 2000, 3000],
        [4000]
      ]
      expected = [6000, 4000]
      expect(day.sums_on_sublists(data)).to eq(expected)
    end
  end
end
