require 'ruby-debug'

describe "#biggest_subarray" do
  describe "no positive values" do
    it 'errors if no positive values in array' do
      lambda do
        biggest_subarray([-1])
      end.should raise_error
    end
  end

  describe "1 item array" do
    it '[5] returns [5, [5]]' do
      biggest_subarray([5]).should == [5, [5]]
    end

    it '[4] returns [4, [4]]' do
      biggest_subarray([4]).should == [4, [4]]
    end
  end

  describe "2 item array" do
    it '[1, 2] returns [3, [1, 2]] ' do
      biggest_subarray([1, 2]).should == [3, [1, 2]]
    end
  end

  describe "3 item array" do
    it '[1, -1, 2] returns [2, [1, -1, 2]] ' do
      biggest_subarray([1, -1, 2]).should == [2, [1, -1, 2]]
    end
  end

  describe "9 item array" do
    it "[-2, 1, -3, 4, -1, 2, 1, -5, 4] returns [6, [4, -1, 2, 1]" do
      biggest_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]).should == [6, [4, -1, 2, 1]]
    end
  end
end

def biggest_subarray(ar)
  raise "need at least one negative value" if ar.reject{ |a| a < 0 }.empty?

  max_answer = []

  1.upto(ar.size) do |i|
    ar.each_cons(i) do |a|
      sum = a.inject(:+)
      max_answer = [sum, a] if max_answer.empty? || sum >= max_answer.first
    end
  end

  max_answer
end
