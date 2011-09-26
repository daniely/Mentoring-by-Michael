class BookUtils
  def self.valid_isbn13?(isbn)
    last_digit = isbn[-1].to_i
    last_digit == check_digit(isbn)
  end

  def self.check_digit(isbn)
    prep_isbn = prepare(isbn)
    mult_isbn = alternately_multiply_by_3(prep_isbn)
    10 - mult_isbn % 10
  end

  def self.prepare(isbn)
    new_isbn = isbn.gsub('-','').split('')[0..-2]
    new_isbn.map{|i| i.to_i}
  end

  def self.alternately_multiply_by_3(isbn)
    isbn[0..-1].each_with_index.inject(0){ |sum, (n, i)| sum += i % 2 == 0 ? n : n * 3 }
  end
end
