require './book_utils'
require 'rspec'

describe BookUtils, "#valid_isbn13" do
  it "should return true for valid ISBN numbers" do
    BookUtils.valid_isbn13?('9780552145428').should be_true
    BookUtils.valid_isbn13?('978-1593272814').should be_true
  end

  it "should return false for invalid ISBN numbers" do
    BookUtils.valid_isbn13?('9780552145438').should be_false
  end
end
