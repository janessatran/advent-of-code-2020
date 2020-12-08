module Day8
  class << self
    def get_data
      instructions = []
      File.readlines("input.txt").map do |line|
        instruction = line.chomp.split(" ")
        instruction[-1] = instruction[-1].to_i
        instructions << instruction
      end
      instructions
    end

    def accumulate(instructions)
      accumulator = 0
      visited_idxs = []
      idx = 0

      while idx < instructions.length && visited_idxs.include?(idx) == false
        cmd = instructions[idx][0]
        val = instructions[idx][1]
        # pp "cmd: #{cmd}, val: #{val}, idx: #{idx}"
        case cmd
          when "acc" then accumulator += val
          when "jmp"
            visited_idxs << idx
            idx += val
            next
          when "nop"
            visited_idxs << idx
            idx += 1
            next
        end
        visited_idxs << idx
        idx += 1
      end
      # pp "last idx: #{idx}"
      [accumulator, visited_idxs]
    end

    def part_one
      result = self.accumulate(self.get_data)
      pp "visited_idxs: #{result.last}"
      pp "accumulator sum: #{result.first}"
    end

    def fix_and_accumulate
      instructions = self.get_data
      # loop through all changed versions of the instructions
      # pass to accumulator
      idxs_to_switch = []
      instructions.each_with_index do |arr, idx|
        idxs_to_switch << idx if (arr.include?("jmp") || arr.include?("nop"))
      end

      instruction_iterations = [instructions]

      idxs_to_switch.each do |idx|
        temp = self.get_data
        if temp[idx][0] == "jmp"
          temp[idx][0] = "nop"
        else
          temp[idx][0] = "jmp"
        end

        instruction_iterations << temp
      end

      instruction_iterations.each do |i|
        # pp i
        result = self.accumulate(i)
        if result.last.include?(i.length - 1)
          pp "visited_idxs: #{result.last}"
          pp "accumulator sum: #{result.first}"
          break
        end
      end
    end
  end
end
