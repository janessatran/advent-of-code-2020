module Day11
  class << self
    def get_data
      seats = []
      File.readlines("input.txt").map do |line|
        seats << line.chomp.split('')
      end
      seats
    end

    def get_adjacent_seats(arr, r, c)
      rows_ndx = arr.each_index.select { |i| (i-r).abs < 2 }
      cols_ndx = arr.first.size.times.select { |j| (j-c).abs < 2 }
      rows_ndx.each_with_object([]) do |i,a|
        cols_ndx.each { |j| a << arr[i][j] unless [i,j] == [r,c] }
      end
    end

    def get_first_sight_seat(arr, r, c)
      # before seat in same row
      first_before = arr[r][..c - 1].select { |s| s != "." }.first
      return first_before if first_before != nil

      # column seats
      column_seats = []
      arr.each do |row|
        column_seats << row[c] unless row[c] == "."
      end
      return column_seats.first unless column_seats.empty?

      # after seat in same row
      first_after = arr[r][c + 1..-1].select { |s| s != "." }.first
      return first_after if first_after != nil
    end

    # If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
    # If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
    # Otherwise, the seat's state does not change.
    def part_one
      current_seats = self.get_data
      next_seats = current_seats.map(&:clone)
      while true
        current_seats.each_with_index do |row, r|
          row.each_with_index do |seat, c|
            if seat == "L"
              next_seats[r][c] = "#" if self.get_adjacent_seats(current_seats, r, c).all? { |s| s == "L" || s == "." }
            elsif seat == "#"
              next_seats[r][c] = "L" if self.get_adjacent_seats(current_seats, r, c).count { |s| s == "#" } >= 4
            end
          end
        end
        break if current_seats == next_seats
        current_seats = next_seats.map(&:clone)
      end
      pp current_seats.inject(0) { |total, row| total += row.count("#")}
    end

    def part_two
      current_seats = self.get_data
      next_seats = current_seats.map(&:clone)
      while true
        current_seats.each_with_index do |row, r|
          row.each_with_index do |seat, c|
            if seat == "L"
              next_seats[r][c] = "#" if self.get_first_sight_seat(current_seats, r, c) == "L"
            elsif seat == "#"
              next_seats[r][c] = "L" if self.get_adjacent_seats(current_seats, r, c).count { |s| s == "#" } >= 5
            end
          end
        end
        break if current_seats == next_seats
        current_seats = next_seats.map(&:clone)
      end
      pp current_seats
      pp current_seats.inject(0) { |total, row| total += row.count("#")}
    end
  end

end
