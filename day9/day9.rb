module Day9
  class << self

    def get_data
      data = []
      File.readlines("input.txt").map do |line|
        data << line.chomp.to_i
      end
      data
    end

    def part_one
      data = self.get_data
      start_idx = 0
      end_idx = 24
      target_idx = end_idx + 1
      target_val = data[target_idx]

      while end_idx < data.length - 1
        found = false
        # pp "target_val: #{target_val}"
        (start_idx..end_idx).each do |idx|
          needed_num = (target_val - data[idx])
          found = true if data[start_idx..end_idx].include?(needed_num)
        end
        # pp found
        if found
          start_idx +=1
          end_idx += 1
          target_idx = end_idx + 1
          target_val = data[target_idx]
        else
          return target_val
        end
      end
    end

    def part_two
      target_val = self.part_one
      data = self.get_data
      idx = 0

      (idx..data.length-1).each do |idx|
        sum = data[idx]
        (idx+1..data.length-1).each do |idx2|
          # break condition: if the sum == target
          if sum == target_val
            return data[idx..idx2-1].min + data[idx..idx2-1].max
          else
            sum += data[idx2]
          end
        end
      end
    end
  end
end
