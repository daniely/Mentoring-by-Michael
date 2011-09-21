class BookUtils
  # algo
  # last isbn digit == check digit?
  def self.valid_isbn13?(isbn)
    last_isbn = isbn.split('')[-1].to_i
    last_isbn == check_digit(isbn)
  end

  def self.check_digit(isbn)
    cleaned_isbn = clean_isbn(isbn)

    # 10 - (x1 + 3 * x2, + x3 + 3 * x4) % 10
    10 - alternately_mult(cleaned_isbn) % 10
  end

  def self.alternately_mult(sample)
    sample.each_with_index.inject(0){ |sum, (n,i)| sum += i % 2 == 0 ? n : n*3 }
  end

  private

  def self.clean_isbn(isbn)
    # remove non-digits
    isbn.gsub!('-','')

    # get it in a format we can work with
    isbn_a = isbn.split('').map{ |n| n.to_i }

    # ignore last digit
    isbn_a[0..-2]
  end
end
