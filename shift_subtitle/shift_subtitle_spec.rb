require './shift_subtitle'

sample_subs =<<-EOS
645
01:31:51,210 --> 01:31:54,893
the government is implementing a new policy...

646
01:31:54,928 --> 01:31:57,664
In connection with a dramatic increase
in crime in certain neighbourhoods,
EOS

# shift_subtitle --operation add --time 02,110 input_file output_file

describe ShiftSubtitle do
  describe "#shift" do
    it 'shifts 01:31:51,210' do
      ShiftSubtitle::shift("01:31:51,210", 2500).should == "01:31:53,710"
    end

    it 'shifts 01:32:07,769' do
      ShiftSubtitle::shift("01:32:07,769", 2500).should == "01:32:10,269"
    end
  end
end
