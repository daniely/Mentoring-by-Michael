describe "#biggest_subarray" do
  describe "biggest_subarray([5])" do
    it 'returns [5, [5]]' do
      biggest_subarray([5]).should == [5, [5]]
    end

    describe "biggest_subarry([4])" do
      it 'returns [4, [4]]' do
        biggest_subarray([4]).should == [4, [4]]
      end
    end
  end
end

def biggest_subarray(ar)
  first = ar.pop
  [first, [first]]
end
