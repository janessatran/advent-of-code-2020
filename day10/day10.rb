# day10.rb

module Day10
  class << self
    def get_data
      data = []
      File.readlines('input.txt').map do |line|
        data << line.chomp.to_i
      end
      data
    end

    def get_adapters
      adapters = self.get_data.sort
      adapters.unshift(0)
      adapters.push(adapters.last + 3)
      adapters
    end

    def part_one
      adapters = get_adapters
      differences = adapters.each_cons(2).map{|a, b| b - a}
      pp differences
      differences.count(1) * differences.count(3)
    end

    def part_two
      adapters = self.get_adapters
      valid = adapters.each_with_index.map do |adapter, index|
        pp "adapter: #{adapter}"
        window = adapters[index + 1, 3]
        pp "window: #{window}"
        valid_neighbors = window.select { |a| a <= adapter + 3 }
        pp "valid_neighbors: #{valid_neighbors}"
        [adapter, valid_neighbors]
      end

      scores = []
      pp "scores: #{scores}"
      valid.reverse.each do |adapter, valid_neighbors|
        if valid_neighbors.size.zero?
          scores[adapter] = 1
        else
          x = valid_neighbors.map { |neighbor| scores[neighbor] }
          pp "valid_neighbors: #{valid_neighbors}"
          pp "x: #{x}"
          scores[adapter] = x.sum
        end
        pp "scores[#{adapter}]: #{scores[adapter]} "
      end

      scores.first

    end
  end
end
