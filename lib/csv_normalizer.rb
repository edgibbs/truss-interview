require 'active_support'
require 'active_support/time'
require 'time'

class CsvNormalizer
  def normalize(row)
    unless row.header_row?
      convert_timestamp_to_iso_8601_eastern(row)
    end
    row
  rescue => error
    STDERR.puts error
  end

  private

  def convert_timestamp_to_iso_8601_eastern(row)
    row[:timestamp] = Time.parse(row[:timestamp]).in_time_zone('US/Eastern').iso8601
  end
end
