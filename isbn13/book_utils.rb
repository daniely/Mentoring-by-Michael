class BookUtils
  # algo
  # last isbn digit == check digit?
  def self.valid_isbn13?(isbn)
    last_isbn = isbn.split('')[-1].to_i
    last_isbn == check_digit(isbn)
  end

  def self.check_digit(isbn)
    # alternate n + n*3
    # result % 10
    # 10 - result
  end
end
