require 'csv'

class LineProcessor
  def initialize(standard_in = STDIN)
    @standard_in = standard_in
  end

  def normalize_lines
    updated_csv = []
    CSV.parse(@standard_in, headers: true, header_converters: :symbol, return_headers: true) do |row|
      updated_csv << row
    end
    CSV.generate("") do |csv|
      updated_csv.each do |row|
        csv << row
      end
    end
  end
end
