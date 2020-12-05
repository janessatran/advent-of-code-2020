module Day2
  class << self
    def get_data
      policies = []
      File.readlines('input.txt').map do |str|
        policy = {}
        parts = str.split(' ')
        counts = parts[0].split('-')
        letter = parts[1].delete(':')
        password = parts[2]

        policy[:num1] = counts.first.to_i
        policy[:num2] = counts.last.to_i
        policy[:letter] = letter
        policy[:password] = password

        policies << policy
      end

      policies
    end

    def get_valid_passwords_count(policies_and_passwords)
      valid_passwords = 0
      policies_and_passwords.each do |pp|
        count_letter_in_password = pp[:password].count(pp[:letter])
        min_count = pp[:num1]
        max_count = pp[:num2]
        valid_passwords += 1 if count_letter_in_password >= min_count && count_letter_in_password <= max_count
      end
      valid_passwords
    end

    def get_valid_passwords_count_part_two(policies_and_passwords)
      valid_passwords = 0
      policies_and_passwords.each do |pp|
        chars = pp[:password].split('')
        idx_one = pp[:num1] - 1
        idx_two = pp[:num2] - 1
        letter = pp[:letter]

        first_idx_contains_letter = (chars[idx_one] == letter && chars[idx_two] != letter)
        second_idx_contains_letter = (chars[idx_one] != letter && chars[idx_two] == letter)
        valid_passwords += 1 if (first_idx_contains_letter || second_idx_contains_letter)
      end
      valid_passwords
    end

    def print_answers
      input = self.get_data
      pp "Part 1: #{get_valid_passwords_count input}"
      pp "Part 2: #{get_valid_passwords_count_part_two input}"
    end
  end
end
