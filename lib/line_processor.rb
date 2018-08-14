require 'csv'
require_relative 'csv_normalizer'

class LineProcessor
  def initialize(standard_in = STDIN)
    @standard_in = standard_in
  end

  def normalize_lines
    updated_csv = []
    utf8_input = encode_to_utf8(@standard_in.readlines.join(''))
    CSV.parse(utf8_input, headers: true, header_converters: :symbol, return_headers: true) do |row|
      normalized_row = CsvNormalizer.new.normalize(row)
      updated_csv << normalized_row if normalized_row
    end
    CSV.generate("") do |csv|
      updated_csv.each do |row|
        csv << row
      end
    end
  end

  private

  def encode_to_utf8(string)
    string.encode("UTF-8", { :invalid => :replace, :undef => :replace, :replace => "\uFFFD" })
  end
end
