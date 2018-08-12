class LineProcessor
  def initialize(standard_in = STDIN)
    @standard_in = standard_in
  end

  def normalize_lines
    @standard_in.each do |line|
      puts line
    end
  end
end
