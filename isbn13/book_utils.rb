class BookUtils
  # algo
  # last isbn digit == check digit?
  def self.valid_isbn13?(isbn)
    last_isbn = isbn.split('')[-1].to_i
    last_isbn == check_digit(isbn)
  end

  def self.check_digit(isbn)
    # remove non-digits
    isbn.gsub!('-','')

    # get it in a format we can work with
    isbn_a = isbn.split('').map{ |n| n.to_i }

    # ignore last digit
    isbn_a = isbn_a[0..-2]

    # alternate n + n*3
    alt = isbn_a.each_with_index \
                .inject(0){ |sum, (n,i)| sum += i.next % 2 ? n : n*3 }

    # result % 10
    alt = alt % 10

    # 10 - result
    alt = 10 - alt
  end
end
