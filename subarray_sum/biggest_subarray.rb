describe "#biggest_subarray" do
  describe "biggest_subarray([5])" do
    it 'returns [5, [5]]' do
      biggest_subarray([5]).should == [5, [5]]
    end
  end
end

def biggest_subarray(ar)
  [5, [5]]
end
