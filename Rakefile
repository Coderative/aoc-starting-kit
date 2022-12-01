require_relative "./lib/loader"

namespace :aoc do
  task :solve, [:day, :part] do  |task, args|
    day_class = Object.const_get("Day#{args[:day]}")
    input_file = "data/day#{args[:day]}.txt"
    day = day_class.new(input_file: input_file)

    start = Time.now
    result = day.solve(part: args[:part].to_i)
    finish = Time.now
    time = finish - start
    puts "Result: #{result}"
    puts "Took: #{time}s"
  end
end
