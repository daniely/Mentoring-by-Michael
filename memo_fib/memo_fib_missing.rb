require 'ruby-debug'

class FibFun
  # init the first two fib values
  define_singleton_method("fib_0") { 0 }
  define_singleton_method("fib_1") { 1 }

  def self.method_missing(meth, *args)
    num = meth.to_s.match(/fib_(\d)*/)[1]

    num = Integer(num) rescue raise("fib_x - where x must be an integer")

    define_singleton_method( "fib_#{num}") do
      send("fib_#{num-1}") + send("fib_#{num-2}")
    end

    # call itself again
    send(meth)
  end
end

describe FibFun do
  describe "Fib.fib_f" do
    it 'raises error' do
      expect do
        FibFun.fib_f
      end.should raise_error
    end
  end

  describe "Fib.fib_0" do
    it 'return 0' do
      FibFun.fib_0.should == 0
    end
  end

  describe "Fib.fib_1" do
    it 'return 1' do
      FibFun.fib_1.should == 1
    end
  end

  describe "FibFun.fib_2" do
    it 'return 1' do
      FibFun.fib_2.should == 1
    end
  end

  describe "FibFun.fib_3" do
    it 'return 2' do
      FibFun.fib_3.should == 2
    end
  end

  describe "FibFun.fib_6" do
    it 'return 8' do
      FibFun.fib_6.should == 8
    end
  end
end
