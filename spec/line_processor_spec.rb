require_relative '../lib/line_processor'

describe LineProcessor do
  describe '#normalize_lines' do
    context 'when UTF-8 string is provided' do
      let(:input) { StringIO.new('LINE\nline 1\nline 2') }

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
    end

    context 'when there are 2 lines with a header' do
      let(:input) { StringIO.new("LINE\nline 1\nline 2") }

      it 'returns two lines and header' do
        expect(LineProcessor.new(input).normalize_lines).to eq "LINE\nline 1\nline 2\n"
      end
    end
  end
end
