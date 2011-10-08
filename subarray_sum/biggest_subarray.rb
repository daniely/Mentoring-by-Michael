require 'ruby-debug'

describe "#biggest_subarray" do
  describe "single value array" do
    it '[5] returns [5, [5]]' do
      biggest_subarray([5]).should == [5, [5]]
    end

    it '[4] returns [4, [4]]' do
      biggest_subarray([4]).should == [4, [4]]
    end

    it 'throw error for invalid array' do
      lambda do
        biggest_subarray([-1])
      end.should raise_error
    end
  end

  describe "two item array" do
    it '[1, 2] returns [3, [1, 2]] ' do
      biggest_subarray([1, 2]).should == [3, [1, 2]]
    end
  end

  describe "three item array" do
    it '[1, -1, 2] returns [2, [1, -1, 2]] ' do
      biggest_subarray([1, -1, 2]).should == [2, [1, -1, 2]]
    end
  end

  describe "[-2, 1, -3, 4, -1, 2, 1, -5, 4] returns [6, [4, -1, 2, 1]" do
    it 'return correct value' do
      biggest_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]).should == [6, [4, -1, 2, 1]]
    end
  end
end

def biggest_subarray(ar)
  raise "need at least one negative value" if ar.reject{ |a| a < 0 }.empty?

  max = ar.inject(:+)

  if ar.size == 1
    [max, [max]]
  elsif ar.select{ |a| a < 0 }.empty?
    [max, ar]
  else
    max_answer = [max, ar]
    1.upto(ar.size) do |i|
      ar.each_cons(i) do |a|
        max = a.inject(:+)
        if max > max_answer.first
          max_answer = [max, a]
        end
      end
    end
    max_answer
  end
end
