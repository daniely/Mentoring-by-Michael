require 'ruby-debug'

class FibFun
  def method_missing(meth, *args)
    num = meth.to_s.split('_').last.to_i

    # get list of fib_x methods
    fib_methods = []
    self.methods.each { |m| fib_methods << m if m.match(/fib_\d*/) }

    # get last fib_x method and calculate the rest
    last_fib_method = fib_methods.last
    debugger

    # compute from lowest to highest for all uncalculated fib sequences
    if num == 0 || num == 1
      self.class.send(:define_method, "fib_" + num.to_s) do
        num
      end
    else
      self.class.send(:define_method, "fib_" + num.to_s) do
        send("fib_" + (num-1).to_s) + send("fib_" + (num-2).to_s)
      end
    end

    # call itself again
    send(meth)
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
      i
    else
      send("fib_" + (i-1).to_s) + send("fib_" + (i-2).to_s)
    end
  end
end

describe FibFun do
  let(:f) { FibFun.new }

  describe "fib(0)" do
    it 'return 0' do
      f.fib_0.should == 0
    end
  end

  describe "fib(1)" do
    it 'return 1' do
      f.fib_1.should == 1
    end
  end

  #describe "fib(2)" do
    #it 'return 1' do
      #f.fib(2).should == 1
    #end
  #end

  #describe "fib(3)" do
    #it 'return 2' do
      #f.fib(3).should == 2
    #end
  #end

  #describe "fib(6)" do
    #it 'return 8' do
      #f.fib(6).should == 8
    #end
  #end
end
