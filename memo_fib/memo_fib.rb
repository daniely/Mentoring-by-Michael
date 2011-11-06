require 'ruby-debug'

# keep a hash of fib sequences
# {0:1, 1:1, 2:2...}
class Fib
  attr_accessor :memo

  def initialize
    self.memo = []
  end

  def fib(i)
    unless memo.include?(i)
      # compute from lowest to highest for all uncalculated fib sequences
      self.memo.size.upto(i) { |n| compute_fib(n) }
    end

    self.memo[i]
  end

  def compute_fib(i)
    if i == 0 || i == 1
      self.memo[i] = i
    else
      self.memo[i] = self.memo[i-1] + self.memo[i-2]
    end
  end
end

describe Fib do
  let(:f) { Fib.new }

  describe "fib(0)" do
    it 'return 0' do
      f.fib(0).should == 0
    end
  end

  describe "fib(1)" do
    it 'return 1' do
      f.fib(1).should == 1
    end
  end

  describe "fib(2)" do
    it 'return 1' do
      f.fib(2).should == 1
    end
  end

  describe "fib(3)" do
    it 'return 2' do
      f.fib(3).should == 2
    end
  end

  describe "fib(6)" do
    it 'return 8' do
      f.fib(6).should == 8
    end
  end
end
