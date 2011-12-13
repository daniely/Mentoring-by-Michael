class Polynomial
  attr_accessor :poly

  def initialize(n)
    raise ArgumentError, "Need at least 2 coefficients" if n.size < 2

    result = n.clone
    result.reverse!.map!(&:to_s)
    result = result.map.with_index do |a, i|
      unless i == 0
        if a == "0"
          nil
        else
          a == "1" ? "x^#{i}" : "#{a}x^#{i}"
        end
      else
        a
      end
    end

    self.poly = result.compact.reverse.join('+').gsub("+-", '-')
  end

  def to_s
    self.poly
  end
end
