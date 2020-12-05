module Day4
  class << self
    def get_data
      passports = []
      File.foreach("input.txt", "\n\n") do |str|
        passport = {}
        parts = str.split(' ')
        parts.each do |part|
          data = part.split(':')
          passport[data.first] = data.last
        end

        passports << passport
      end
      passports
    end

    # byr (Birth Year)
    # iyr (Issue Year)
    # eyr (Expiration Year)
    # hgt (Height)
    # hcl (Hair Color)
    # ecl (Eye Color)
    # pid (Passport ID)
    # cid (Country ID)
    def count_valid_passports
      required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
      passports = self.get_data
      valid_passports = 0
      passports.each do |passport|
        valid_passports += 1 if required_fields.all? { |field| passport.has_key?(field) }
      end
      valid_passports
    end

    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    # hgt (Height) - a number followed by either cm or in:
	# 	If cm, the number must be at least 150 and at most 193.
	#   If in, the number must be at least 59 and at most 76.
    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    # cid (Country ID) - ignored, missing or not.
    def count_valid_passports_part_two
      required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
      passports = self.get_data
      valid_passports = 0
      passports.each do |passport|
        if required_fields.all? { |field| passport.has_key?(field) } == false
          next
        else
          field_validities = []
          if required_fields.each do |field|
              case field
              when "byr"
                field_validities << (passport[field].length == 4 && passport[field].to_i >= 1920 && passport[field].to_i <= 2002)
              when "iyr"
                field_validities << (passport[field].length == 4 && passport[field].to_i >= 2010 && passport[field].to_i <= 2020)
              when "eyr"
                field_validities << (passport[field].length == 4 && passport[field].to_i >= 2020 && passport[field].to_i <= 2030)
              when "hgt"
                if !passport[field].match?(/\d+(\.\d+)?(cm|in)/)
                  field_validities << false
                else
                  if passport[field].include?('cm')
                  	height = passport[field].partition('cm').first.to_i
                  	field_validities << (height >= 150 && height <= 193)
                  else
                  	height = passport[field].partition('in').first.to_i
                	field_validities << (height >= 59 && height <= 76)
                  end
                end
              when "hcl"
                field_validities << (passport[field].match?(/^\A#(\d|[a-f]){6}$/))
              when "ecl"
                field_validities << (["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].one? { |color| passport[field] == color })
              when "pid"
                field_validities << (passport[field].match?(/^\d{9}$/))
              end
            end
          end
          valid_passports += 1 if field_validities.uniq == [true]
        end
      end
      valid_passports
    end
  end
end
