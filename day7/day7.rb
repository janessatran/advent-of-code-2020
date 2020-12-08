require 'rgl/adjacency'
require "rgl/traversal"
require "rgl/path"

module Day7
  class << self
    def get_data
      graph = RGL::DirectedAdjacencyGraph.new
      weights = {}
      File.readlines("input.txt").map do |rule|
        temp = {}
        rules = rule.scan(/(\w+ \w+) bag/).flatten
        parent = rules.first
        rules_with_nums = rule.scan(/(\d+ \w+ \w+) bag/).flatten
        rules_with_nums.each do |rule|
          _, weight, child = rule.match(/(\d+) (\w+ \w+)/).to_a
          edge = [parent, child]
          weights[edge] = weight.to_i
        end
        weights.each { |(parent, child), weight| graph.add_edge(parent, child) }
      end
      [graph, weights]
    end

    def get_possible_container_purses(purse)
      graph, weights = self.get_data
      reverse_graph = graph.reverse
      search = reverse_graph.dfs_iterator
      search.start_vertex = purse
      search.count - 1
    end

    def part_one
      pp get_possible_container_purses("shiny gold")
    end

    def sum_contained_bags(graph, weights, container_bag)
      contained_bags = graph.adjacent_vertices(container_bag)
      contained_bags.inject(1) do |sum, bag|
        sum + (sum_contained_bags(graph, weights, bag) * weights[[container_bag, bag]])
      end
    end

    def part_two
      graph, weights = self.get_data
      sum_contained_bags(graph, weights, "shiny gold") - 1
    end
  end
end
