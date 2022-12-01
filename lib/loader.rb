require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.inflector.inflect(
  "aoc" => "AOC"
)
loader.push_dir("lib")
loader.setup
