require_relative '../lib/csv_normalizer'
require 'csv'

describe CsvNormalizer do
  let(:csv_normalizer) { CsvNormalizer.new }
  describe '#normalize' do
    context 'for the timestamp column' do
      context 'for a valid timestamp' do
        let(:row) { CSV::Row.new([:timestamp], ['4/1/11 11:00:00:00 AM']) }

        it 'formats time in ISO-8601 and eastern time' do
          expect(csv_normalizer.normalize(row)[:timestamp]).to eq "2004-01-11T14:00:00-05:00"
        end
      end

      context 'for a header row' do
        let(:row) { CSV::Row.new([:timestamp], ['4/1/11 11:00:00:00 AM'], true) }

        it 'returns the row unmodified' do
          expect(csv_normalizer.normalize(row)).to eq row
        end
      end

      context 'for an invalid timestamp' do
        let(:row) { CSV::Row.new([:timestamp], ["2002 \uFFFD"]) }

        it 'prints an error' do
          expect(STDERR).to receive(:puts)
          csv_normalizer.normalize(row)
        end

        it 'returns nil' do
          expect(csv_normalizer.normalize(row)).to eq nil
        end
      end
    end
  end
end
