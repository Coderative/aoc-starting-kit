RSpec.describe Day10 do
  subject { day.solve(part: part) }

  let(:day) { described_class.new(input_file: input_file) }
  let(:input_file) { "spec/fixtures/day10.txt" }
  let(:part) { 1 }

  context "part one" do
    it { is_expected.to eq(13_140) }

    it "parses a noop command" do
      command = "noop"
      parsed_command = day.parse_command(command)
      expect(parsed_command).to match({duration: 1, function: Proc})

      expect(parsed_command[:function].call(5)).to eq(5)
    end

    it "parses a addx 3 command" do
      command = "addx 3"
      parsed_command = day.parse_command(command)
      expect(parsed_command).to match({duration: 2, function: Proc})

      expect(parsed_command[:function].call(5)).to eq(8)
    end

    it "parses a addx 5 command" do
      command = "addx 5"
      parsed_command = day.parse_command(command)
      expect(parsed_command).to match({duration: 2, function: Proc})

      expect(parsed_command[:function].call(5)).to eq(10)
    end

    it "parses a addx -5 command" do
      command = "addx -5"
      parsed_command = day.parse_command(command)
      expect(parsed_command).to match({duration: 2, function: Proc})

      expect(parsed_command[:function].call(2)).to eq(-3)
    end

    it "parses a addx -30 command" do
      command = "addx -30"
      parsed_command = day.parse_command(command)
      expect(parsed_command).to match({duration: 2, function: Proc})

      expect(parsed_command[:function].call(2)).to eq(-28)
    end

    it "executes a series of commands" do
      commands = [
        "noop",
        "addx 3",
        "addx -5"
      ]
      initial_register = 1
      register_values = day.execute_commands(initial_register, commands)
      expect(register_values).to eq([1, 1, 1, 4, 4, -1])
    end

    it "executes a series of commands" do
      commands = [
        "addx 15",
        "addx -11",
        "addx 6",
        "addx -3",
        "addx 5"
      ]
      initial_register = 1
      register_values = day.execute_commands(initial_register, commands)
      expect(register_values).to eq([1, 1, 16, 16, 5, 5, 11, 11, 8, 8, 13])
    end
  end

  context "part two" do
    let(:part) { 2 }
    it "draws an image" do
      drawing = <<~TXT.chomp
        ##..##..##..##..##..##..##..##..##..##..
        ###...###...###...###...###...###...###.
        ####....####....####....####....####....
        #####.....#####.....#####.....#####.....
        ######......######......######......####
        #######.......#######.......#######.....
      TXT
      is_expected.to eq(drawing)
    end

    it "determines whether to draw a pixel" do
      register_values = [1, 1, 16, 16, 5, 5, 11, 11, 8, 8]
      drawable = [true, true, false, false, true, true, false, false, true, true]

      expect(day.pixels(register_values)).to eq(drawable)
    end

    it "detects left pixel to be drawn" do
      value = 1
      index = 0
      expect(day.is_drawable?(value, index)).to be(true)
    end

    it "detects center pixel to be drawn" do
      value = 1
      index = 1
      expect(day.is_drawable?(value, index)).to be(true)
    end

    it "detects right pixel to be drawn" do
      value = 1
      index = 2
      expect(day.is_drawable?(value, index)).to be(true)
    end

    it "does not draw when left of sprite" do
      value = 10
      index = 8
      expect(day.is_drawable?(value, index)).to be(false)
    end

    it "does non tdraw when right of sprite" do
      value = 10
      index = 12
      expect(day.is_drawable?(value, index)).to be(false)
    end

    it "does draw left pixel on another line" do
      value = 1
      index = 40
      expect(day.is_drawable?(value, index)).to be(true)
    end

    it "detects center pixel on another line" do
      value = 1
      index = 41
      expect(day.is_drawable?(value, index)).to be(true)
    end

    it "detects right pixel to be drawn on another line" do
      value = 1
      index = 42
      expect(day.is_drawable?(value, index)).to be(true)
    end

    it "does not draw when left of sprite on another line" do
      value = 10
      index = 48
      expect(day.is_drawable?(value, index)).to be(false)
    end

    it "does draw when right of sprite on another line" do
      value = 10
      index = 52
      expect(day.is_drawable?(value, index)).to be(false)
    end
  end
end
