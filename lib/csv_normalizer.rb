require 'active_support'
require 'active_support/time'
require 'time'

class CsvNormalizer
  def normalize(row)
    unless row.header_row?
      convert_timestamp_to_iso_8601_eastern(row)
      convert_zip_codes_to_5_numbers(row)
    end
    row
  rescue => error
    STDERR.puts error
  end

  private

  def convert_timestamp_to_iso_8601_eastern(row)
    row[:timestamp] = Time.parse(row[:timestamp]).in_time_zone('US/Eastern').iso8601
  end

  def convert_zip_codes_to_5_numbers(row)
    row[:zip] = row[:zip].rjust(5, "0")
  end
end
