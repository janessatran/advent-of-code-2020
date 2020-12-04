module Day3
	class << self
		def get_data
      map_rows = []
			File.readlines('input.txt').map do |row|
        map_rows << row.chomp
			end
      map_rows
    end

    def count_trees(steps_right: 0, steps_down: 0)
      map_rows = self.get_data
      x = 0
      y = steps_down
      count_trees = 0

      while y < map_rows.length
        x = (x + steps_right) % map_rows[y].length
        count_trees += 1 if map_rows[y][x] == "#"
        y += steps_down
      end

      count_trees
    end

    def print_answer_part_one
      self.count_trees(steps_right: 3, steps_down: 1)
    end

    def print_answer_part_two
      count1 = self.count_trees(steps_right: 1, steps_down: 1)
      count2 = self.count_trees(steps_right: 3, steps_down: 1)
      count3 = self.count_trees(steps_right: 5, steps_down: 1)
      count4 = self.count_trees(steps_right: 7, steps_down: 1)
      count5 = self.count_trees(steps_right: 1, steps_down: 2)
      count1 * count2 * count3 * count4 * count5
    end
  end
end
