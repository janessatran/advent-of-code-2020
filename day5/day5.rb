module Day5
	class << self
		def get_data
			passports = []
			File.readlines("input.txt").map do |line|
				passports << line.chomp
			end
			passports
		end

		def in_half(a)
			left, right = a.each_slice( (a.size/2.0).round ).to_a
			return left, right
		end

		def get_seat_ids
			passports = self.get_data
			seat_ids = []
			passports.each do |passport|
				row = (0..127).to_a
				row_directions = passport.chars.first(7)
				row_directions.each do |direction|
					if direction == "F" #lower half
						row = self.in_half(row).first
					else #upper half
						row = self.in_half(row).last
					end
				end
				column = (0..7).to_a
				seat_directions = passport.chars.last(3)
				seat_directions.each do |direction|
					if direction == "L" #lower half
						column = self.in_half(column).first
					else #upper half
						column = self.in_half(column).last
					end
				end
				seat_id = row.first * 8 + column.first
				seat_ids << seat_id
			end
			seat_ids.sort
		end

		def get_max_seat_id
			self.get_seat_ids.last
		end

		def find_my_seat_id
			seat_ids = self.get_seat_ids
			possible_missing = seat_ids.flat_map {|e| [e-1, e+1]}.uniq
			diff = (possible_missing - seat_ids).select {|e| e >= 0}
			diff
		end
	end
end
