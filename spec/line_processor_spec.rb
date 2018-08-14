require_relative '../lib/line_processor'

describe LineProcessor do
  describe '#normalize_lines' do
    let(:csv_normalizer) { instance_double('CsvNormalizer') }

    before do
      allow(CsvNormalizer).to receive(:new).with(no_args).and_return(csv_normalizer)
      allow(csv_normalizer).to receive(:normalize) { |row| row }
    end

    context 'when UTF-8 string is provided' do
      let(:input) { StringIO.new("Timestamp\n1/1/2001\n1/1/2002") }

      it 'returns UTF-8' do
        line_processor = LineProcessor.new(input.set_encoding(Encoding::UTF_8))
        expect(line_processor.normalize_lines.encoding).to eq Encoding::UTF_8
      end
    end

    context 'when non UTF-8 string is provided' do
      let(:bad_characters) { [0x89].pack("c*").force_encoding("ISO-8859-1") }
      let(:input) { StringIO.new("LINE\nline 1\n#{bad_characters}") }

      it 'returns UTF-8' do
        line_processor = LineProcessor.new(input.set_encoding(Encoding::UTF_8))
        expect(line_processor.normalize_lines.encoding).to eq Encoding::UTF_8
      end

      it 'replaces with unicode replacement character' do
        line_processor = LineProcessor.new(input.set_encoding(Encoding::UTF_8))
        expect(line_processor.normalize_lines).to eq "LINE\nline 1\n\uFFFD\n"
      end
    end

    context 'when CsvNormalizer fails to process rows and returns nil' do
      let(:input) { StringIO.new("LINE\nskipped\nline 2") }

      it 'skips rows in output' do
        allow(csv_normalizer).to receive(:normalize) { |row| row.to_s =~ /skipped/ ? nil : row }
        expect(LineProcessor.new(input).normalize_lines).to eq "LINE\nline 2\n"
      end
    end

    context 'when there are 2 lines with a header' do
      let(:input) { StringIO.new("LINE\nline 1\nline 2") }

      it 'returns two lines and header' do
        expect(LineProcessor.new(input).normalize_lines).to eq "LINE\nline 1\nline 2\n"
      end
    end
  end
end
