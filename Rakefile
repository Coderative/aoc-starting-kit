Dir["./lib/*.rb"].sort.each { |f| require f }

namespace :aoc do
  task :solve, [:day, :part] do  |task, args|
    day_class = Object.const_get("Day#{args[:day]}")
    input_file = "data/day#{args[:day]}.txt"
    day = day_class.new(input_file: input_file)

    puts day.solve(part: args[:part].to_i)
  end
end
