RSpec.describe Day7 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day7.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(95437) }

    it "builds an empty tree" do
      input = []
      expected = {}
      expect(day.build_tree(input)).to eq(expected)
    end

    it "builds an empty tree" do
      input = [
        "$ cd /"
      ]
      expected = {"/" => {}}
      expect(day.build_tree(input)).to eq(expected)
    end

    it "builds a flat tree" do
      input = [
        "$ cd /",
        "$ ls",
        "123 a",
        "456 b"
      ]
      expected = {"/" => {"a" => 123, "b" => 456}}
      expect(day.build_tree(input)).to eq(expected)
    end

    it "builds a tree with a subfolder" do
      input = [
        "$ cd /",
        "$ ls",
        "123 a",
        "dir b"
      ]
      expected = {"/" => {"a" => 123, "b" => {}}}
      expect(day.build_tree(input)).to eq(expected)
    end

    it "builds a tree with a subfolder and fills its content" do
      input = [
        "$ cd /",
        "$ ls",
        "123 a",
        "dir b",
        "$ cd b",
        "$ ls",
        "456 c"
      ]
      expected = {"/" => {"a" => 123, "b" => {"c" => 456}}}
      expect(day.build_tree(input)).to eq(expected)
    end

    it "builds a tree with 3 levels of folders" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a",
        "$ cd a",
        "$ ls",
        "dir b"
      ]
      expected = {"/" => {"a" => {"b" => {}}}}
      expect(day.build_tree(input)).to eq(expected)
    end

    it "builds the tree from the example" do
      input = IO.read(input_file).split("\n")
      expected = {
        "/" => {
          "a" => {
            "e" => {
              "i" => 584
            },
            "f" => 29116,
            "g" => 2557,
            "h.lst" => 62596
          },
          "b.txt" => 14848514,
          "c.dat" => 8504156,
          "d" => {
            "j" => 4060174,
            "d.log" => 8033020,
            "d.ext" => 5626152,
            "k" => 7214296
          }
        }
      }
      expect(day.build_tree(input)).to eq(expected)
    end

    it "calculates the size of an empty tree" do
      input = {}
      expected = {}
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates the size of an empty root" do
      input = {"/" => {}}
      expected = {["/"] => 0}
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates the size of an empty root" do
      input = {"/" => {"a" => 123, "b" => 456}}
      expected = {["/"] => 579}
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates the size of tree with one subfolder" do
      input = {"/" => {"a" => {"b" => 123}}}
      expected = {
        ["/"] => 123,
        ["/", "a"] => 123
      }
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates the size of tree with one subfolder" do
      input = {
        "/" => {
          "a" => {
            "b" => 123,
            "c" => 456
          },
          "d" => 789
        }
      }
      expected = {
        ["/"] => 1368,
        ["/", "a"] => 579
      }
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates the size of a tree with 3 levels of nesting" do
      input = {
        "/" => {
          "a" => {
            "b" => 123,
            "c" => 456,
            "d" => {
              "e" => 789
            }
          },
          "f" => 234
        }
      }
      expected = {
        ["/"] => 1602,
        ["/", "a"] => 1368,
        ["/", "a", "d"] => 789
      }
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates sizes correctly even when folders have the same name" do
      input = {
        "/" => {
          "a" => {
            "b" => 123
          },
          "c" => {
            "a" => {
              "d" => 456
            }
          }
        }
      }
      expected = {
        ["/"] => 579,
        ["/", "a"] => 123,
        ["/", "c"] => 456,
        ["/", "c", "a"] => 456
      }
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "calculates the sizes of the example tree" do
      input = {
        "/" => {
          "a" => {
            "e" => {
              "i" => 584
            },
            "f" => 29116,
            "g" => 2557,
            "h.lst" => 62596
          },
          "b.txt" => 14848514,
          "c.dat" => 8504156,
          "d" => {
            "j" => 4060174,
            "d.log" => 8033020,
            "d.ext" => 5626152,
            "k" => 7214296
          }
        }
      }
      expected = {
        ["/"] => 48381165,
        ["/", "a"] => 94853,
        ["/", "a", "e"] => 584,
        ["/", "d"] => 24933642
      }
      expect(day.calculate_sizes(input)).to eq(expected)
    end

    it "adds up the sizes of folders of at most 100_000" do
      input = {
        ["/"] => 48381165,
        ["/", "a"] => 94853,
        ["/", "a", "e"] => 584,
        ["/", "d"] => 24933642
      }
      expected = 95437
      expect(day.sum_of_smaller_folders(input)).to eq(expected)
    end
  end

  context "part two" do
    let(:part) { 2 }
    it { is_expected.to eq(24933642) }

    it "calculates the amount of space that needs to be freed" do
      input = {
        ["/"] => 48381165,
        ["/", "a"] => 94853,
        ["/", "a", "e"] => 584,
        ["/", "d"] => 24933642
      }
      expected = 8381165
      expect(day.to_be_freed(input)).to eq(expected)
    end

    it "indicates the minimum freeable size to apply update" do
      input = {
        ["/"] => 48381165,
        ["/", "a"] => 94853,
        ["/", "a", "e"] => 584,
        ["/", "d"] => 24933642
      }
      expected = 24933642
      expect(day.to_free(input, 8381165)).to eq(expected)
    end
  end
end
