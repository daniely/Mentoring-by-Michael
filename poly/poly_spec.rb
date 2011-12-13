require './poly'
require 'ruby-debug'

describe "test_first_negative" do

  before do
    @p1 = Polynomial.new([-3,-4,1,0,6])
    @p2 = Polynomial.new([1,0,2])
    @p3 = Polynomial.new([-1,-2,3,0])
    @p4 = Polynomial.new([0,0,0])
  end

  it "test first negative" do
    @p1.to_s.should == "-3x^4-4x^3+x^2+6"
  end

  it "test_simple" do
    @p2.to_s.should == "x^2+2"
  end

  it "test_all_zero" do
    @p4.to_s == "0"
  end

  it "test_first_minus_one" do
    @p3.to_s == "-x^3-2x^2+3x"
  end

  it "test_error" do
    expect do
      Polynomial.new([1])
    end.should raise_error(ArgumentError, /Need at least 2 coefficients/)
  end

end


