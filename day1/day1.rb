module Day1
  class << self
    def get_data_array
      data_array = []
      File.readlines('input.txt').map do |num|
        data_array << num.to_i
      end

      data_array
    end

    def find_two_entries_that_sum_to_2020(entry_list)
      sorted_entry_list = entry_list.sort
      sorted_entry_list.each_with_index do |entry, index|
        matching_entry = 2020 - entry.to_i
        if entry_list.include?(matching_entry)
          return matching_entry * entry
        else
          next
        end
      end
    end

    def find_three_entries_that_sum_to_2020(entry_list)
      sorted_entry_list = entry_list.sort
      sorted_entry_list.each_with_index do |entry, index|
        remaining_sum = 2020 - entry.to_i
        other_entries = sorted_entry_list.drop(index).select { |num| num < remaining_sum }
        other_entries.each_with_index do |other_entry, index|
          final_sum = remaining_sum - other_entry.to_i
          if other_entries.include?(final_sum)
            return final_sum * other_entry * entry
          else
            next
          end
        end
      end
    end
  end
end
