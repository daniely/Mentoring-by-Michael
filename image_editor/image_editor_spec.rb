require './image_editor'

describe ImageEditor do
  describe "execute" do
    let(:output) { double('output').as_null_object }
    let(:ie) { ImageEditor.new(output) }

    before(:each) do
      ie.execute("I 5 6")
    end

    describe "I 5 6" do
      it 'creates a new MxN image' do
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
        output.should_receive(:puts).with(image.gsub(' ', '').chomp)
        ie.execute("S")
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
        ie.execute("L 2 3 A")
        ie.to_s.should == image.gsub(' ','').chomp
      end
    end

    describe "V 2 3 4 W" do
      it 'colors a vertical section' do
        image = <<-EOS
                OOOOO
                OOOOO
                OWOOO
                OWOOO
                OOOOO
                OOOOO
                EOS
        ie.execute("V 2 3 4 W")
        ie.to_s.should == image.gsub(' ','').chomp
      end
    end

    describe "H 3 4 2 Z" do
      it 'colors a horizontal section' do
        image = <<-EOS
                OOOOO
                OOZZO
                OOOOO
                OOOOO
                OOOOO
                OOOOO
                EOS
        ie.execute("H 3 4 2 Z")
        ie.to_s.should == image.gsub(' ','').chomp
      end
    end

    describe "F 3 3 J" do
      it 'fills a region' do
        image = <<-EOS
                JJJJJ
                JJJJJ
                JJJJJ
                JJJJJ
                JJJJJ
                JJJJJ
                EOS
        ie.execute("F 3 3 J")
        ie.to_s.should == image.gsub(' ','').chomp
      end
    end

    describe "F 3 3 J with half already colored" do
      it 'colors the right half' do
        image = <<-EOS
                OWJJJ
                OWJJJ
                OWJJJ
                OWJJJ
                OWJJJ
                OWJJJ
                EOS
        ie.execute("V 2 1 6 W")
        ie.execute("F 3 3 J")
        ie.to_s.should == image.gsub(' ','').chomp
      end
    end

    describe "C" do
      it 'resets image' do
        image = <<-EOS
                OOOOO
                OOOOO
                OOOOO
                OOOOO
                OOOOO
                OOOOO
                EOS
        ie.execute("L 2 3 A")
        ie.execute("C")
        ie.to_s.should == image.gsub(' ','').chomp
      end
    end

    context "command input validation" do
      describe "image that is too big" do
        it 'width must be <= 250' do
          too_small = ImageEditor.new(output)
          output.should_receive(:puts).with("Image must be 1 <= m,n <= 250")
          too_small.execute("I 251 3")
        end

        it 'height must be <= 250' do
          too_small = ImageEditor.new(output)
          output.should_receive(:puts).with("Image must be 1 <= m,n <= 250")
          too_small.execute("I 3 251")
        end
      end
      describe "image that is too small" do
        it 'width must be >= 1' do
          too_small = ImageEditor.new(output)
          output.should_receive(:puts).with("Image must be 1 <= m,n <= 250")
          too_small.execute("I -1 3")
        end

        it 'height must be >= 1' do
          too_small = ImageEditor.new(output)
          output.should_receive(:puts).with("Image must be 1 <= m,n <= 250")
          too_small.execute("I 3 -1")
        end
      end
    end
  end
end
