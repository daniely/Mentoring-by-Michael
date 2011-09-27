require './image_editor'

describe ImageEditor do
  describe "commands" do
    describe "I 5 6" do
      it 'creates a new MxN image' do
        ie = ImageEditor.new
        ie.execute("I 5 6")
        # internal representation of image should be 5 x 6 and white
        ie.image.size.should == 5
        ie.image.flatten.size.should == 5 * 6
      end
    end
  end
end
