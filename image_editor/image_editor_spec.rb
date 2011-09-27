require './image_editor'

describe ImageEditor do
  describe "commands" do
    let(:ie) { ImageEditor.new }

    describe "I 5 6" do
      it 'creates a new MxN image' do
        ie.execute("I 5 6")
        ie.image.first.size.should == 5
        ie.image.size.should == 6
      end
    end
  end
end
