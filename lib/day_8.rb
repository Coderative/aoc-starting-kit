class Day8 < AOC
  def solve(part:)
    grid = read_input_file.map { |line| line.chars.map(&:to_i) }

    if part == 1
      count_on_edge(grid) + count_in_center(grid)
    else
      scenic_scores(grid).max
    end
  end

  def count_on_edge(grid)
    width = grid[0].size
    height = grid.size

    2 * (width + height) - 4
  end

  def count_in_center(grid)
    counter = 0
    grid.each.with_index do |row, height_index|
      row.each.with_index do |tree, width_index|
        next if height_index == 0
        next if height_index == grid.size - 1
        next if width_index == 0
        next if width_index == row.size - 1

        left_trees = grid[height_index][0..width_index - 1]
        right_trees = grid[height_index][width_index + 1..]
        top_trees = grid[0..height_index - 1].map { |row| row[width_index] }
        bottom_trees = grid[height_index + 1..].map { |row| row[width_index] }

        visible = [left_trees, right_trees, top_trees, bottom_trees]
          .map { |neighbours| neighbours.all? { |neighbour| tree > neighbour } }
          .any?

        counter += 1 if visible
      end
    end
    counter
  end

  def scenic_scores(grid)
    scores = []
    grid.each.with_index do |row, height_index|
      row.each.with_index do |tree, width_index|
        next if height_index == 0
        next if height_index == grid.size - 1
        next if width_index == 0
        next if width_index == row.size - 1

        left_trees = grid[height_index][0..width_index - 1]
        right_trees = grid[height_index][width_index + 1..]
        top_trees = grid[0..height_index - 1].map { |row| row[width_index] }
        bottom_trees = grid[height_index + 1..].map { |row| row[width_index] }

        score = [left_trees.reverse, right_trees, top_trees.reverse, bottom_trees]
          .map do |neighbours|
            visibles = neighbours.take_while { |neighbour| neighbour < tree }
            offset = (visibles.size == neighbours.size) ? 0 : 1
            visibles.size + offset
          end.reduce(1) { |total, direction| total * direction }

        scores << score
      end
    end
    scores
  end
end
