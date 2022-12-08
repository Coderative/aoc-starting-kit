class Day7 < AOC
  def solve(part:)
    tree = build_tree(read_input_file)
    sizes = calculate_sizes(tree)
    if part == 1
      sum_of_smaller_folders(sizes)
    else
      to_be_freed = to_be_freed(sizes)
      to_free(sizes, to_be_freed)
    end
  end

  def build_tree(input)
    tree = {}
    position = []
    input.each do |line|
      case line
      when "$ cd /"
        tree["/"] = {}
        position = ["/"]
      when "$ cd .."
        position.pop
      when /\$ cd \w/
        dir_name = line.split(" ")[-1]
        position.push(dir_name)
      when "$ ls"
        next
      when /\d+ \w/
        size, name = line.split(" ")
        tree.dig(*position)[name] = size.to_i
      when /dir \w/
        _dir, name = line.split(" ")
        tree.dig(*position)[name] = {}
      end
    end
    tree
  end

  def calculate_sizes(tree)
    sizes = {}
    tree.keys.each do |dir_name|
      position = [dir_name]
      sizes[position] = calculate_folder_size(tree[dir_name], sizes, position)
    end
    sizes
  end

  def sum_of_smaller_folders(folders)
    folders.values.select { |size| size <= 100_000 }.sum
  end

  def to_be_freed(folders)
    total_space = 70_000_000
    space_needed = 30_000_000
    space_used = folders[["/"]]
    space_left = total_space - space_used
    if space_left > space_needed
      0
    else
      space_needed - space_left
    end
  end

  def to_free(folders, to_be_freed)
    folders.values.reject { |size| size < to_be_freed }.min
  end

  private

  def calculate_folder_size(subtree, sizes, position)
    subtree.map do |name, size|
      if size.is_a? Integer
        size
      else
        new_position = position.dup << name
        folder_size = calculate_folder_size(size, sizes, new_position)
        sizes[new_position] = folder_size
        folder_size
      end
    end.sum
  end
end
