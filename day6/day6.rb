module Day6
  class << self
    def get_data
      groups = []
      File.foreach("input.txt", "\n\n") do |g|
        group = {}
        answers = g.gsub("\n", "")
        group[:people_count] = g.count("\n")-1
        group[:uniq_yes_questions] = answers.chars.uniq
        group[:uniq_yes_count] = group[:uniq_yes_questions].count
        group[:all_in_group_yes_count] = 0
        group[:uniq_yes_questions].each do |char|
          group[:all_in_group_yes_count] += 1 if answers.count(char) == group[:people_count]
        end
        groups << group
      end
      groups
    end

    def sum_yes
      groups = self.get_data
      groups.map{|x| x[:uniq_yes_count]}.reduce(:+)
    end

    def sum_yes_to_all_per_group
      groups = self.get_data
      groups.map{|x| x[:all_in_group_yes_count]}.reduce(:+)
    end
  end
end
