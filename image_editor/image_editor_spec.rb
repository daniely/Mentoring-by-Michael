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

    describe "S" do
      it 'shows image' do
        image = <<-EOS
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
EOS
        ie.execute("I 5 6")
        ie.execute("S").should == image.chomp
      end
    end

    describe "L 2 3 A" do
      it 'colors a single pixel' do
        
        image = <<-EOS
OOOOO
OOOOO
OAOOO
OOOOO
OOOOO
OOOOO
EOS

        ie.execute("I 5 6")
        ie.execute("L 2 3 A")
        ie.execute("S").should == image.chomp
      end
    end
  end
end
