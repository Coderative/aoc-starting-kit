## AOC starting kit

A basic setup to start writing code to solve [AOC](adventofcode.com) challenges.

It includes
- `RSpec` setup
- Convention for naming solution classes and where to store helper methods.
- `rake` task to generate answers directly from the command line.

## Setup

- Install a recent version of Ruby
- `bundle install`
- `rake solve[1,1]` to run the solution for AOC 2021 Day 1 part 1.
- Write your own.

## Writing your solutions

- One file per day, e.g. `lib/day_1.rb`
- Name your classes `Day1`, `Day2`, etc.
- Make them inherit from the `AOC` where you can store any helper methods you
  will reuse for different challenges.
- Each `Day#` class should have an instance method `#solve` that accepts one 
  argument : the part of the daily challenge
- Download your inputs into the `data` folder, e.g. `data/day1.txt`

## Testing your solutions

- Write your tests in the `spec` folder, e.g. `spec/day_1_spec.rb`
- You can put the samples given by the challenge in `spec/fixtures/` to use them
  in your tests.
- Run them with `bundle exec rspec`

## Running your solution

If you followed the conventions above, you can run the rake task `rake
aoc:solve[1,2]` to run your solution for the Day1, part 2. (If you're using `zsh`
you will need to escape the brackets `rake aoc:solve\[1,2\]`).
