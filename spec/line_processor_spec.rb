require_relative '../lib/line_processor'

describe LineProcessor do
  describe '#normalize_lines' do
    context 'when there are 2 lines' do
      let(:input) { StringIO.new('line 1\nline 2') }

      it 'returns two lines' do
        expect(LineProcessor.new(input).normalize_lines.string).to eq 'line 1\nline 2'
      end
    end
  end
end
