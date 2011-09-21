require './book_utils'
require 'rspec'

describe BookUtils do
  describe "#valid_isbn13" do
    it "should return true for valid ISBN 9780552145428" do
      BookUtils.valid_isbn13?('9780552145428').should be_true
    end

    it 'should return true for valid ISBN 978-1593272814', r:true do
      BookUtils.valid_isbn13?('978-1593272814').should be_true
    end

    it "should return false for invalid ISBN numbers" do
      BookUtils.valid_isbn13?('9780552145438').should be_false
    end
  end

  describe "#prepare" do
    let(:unclean_isbn) { '978-1593272814' }

    it 'removes special chars (-)' do
      BookUtils.prepare(unclean_isbn).include?('-').should == false
    end

    it 'returns an array of numbers' do
      isbn_a = BookUtils.prepare(unclean_isbn)
      isbn_a.class.should == Array
      isbn_a.each do |i|
        i.class.should == Fixnum
      end
    end

    it 'removes last number in isbn' do
      # -2 because we need to also remove '-'
      BookUtils.prepare(unclean_isbn).size.should == unclean_isbn.size - 2
    end

  end

  describe "#alernately_multiply_by_3" do
    let(:isbn) { '9781'.split('').map{|i| i.to_i} }

    it 'sums by alternately mult every other item by 3' do
      result = BookUtils.alternately_multiply_by_3(isbn)
      result.should == 9 + 7*3 + 8 + 1*3
    end
  end

  describe "#check_digit" do
    let(:isbn) {'9780552145428' }
    let(:isbn2) {'978-1593272814' }

    it "calculates check digit for 9780552145428" do
      check = BookUtils.check_digit(isbn)
      manual = 9 + 7*3 + 8 + 0*3 + 5 + 5*3 + 2 + 1*3 + 4 + 5*3 + 4 + 2*3
      manual = 10 - manual % 10
      check.should == manual
    end

    it "calculates check digit for 978-1593272814" do
      check = BookUtils.check_digit(isbn2)
      manual = 9 + 7*3 + 8 + 1*3 + 5 + 9*3 + 3 + 2*3 + 7 + 2*3 + 8 + 1*3
      manual.should == 106
      manual = 10 - manual % 10
      check.should == manual
    end
  end
end
