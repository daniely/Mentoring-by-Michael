require 'spec_helper'

sample_subs =<<-EOS
645
01:31:51,210 --> 01:31:54,893
the government is implementing a new policy...

646
01:31:54,928 --> 01:31:57,664
In connection with a dramatic increase
in crime in certain neighbourhoods,
EOS

shifted =<<-EOS
645
01:31:53,710 --> 01:31:57,393
the government is implementing a new policy...

646
01:31:57,428 --> 01:32:00,164
In connection with a dramatic increase
in crime in certain neighbourhoods,
EOS

describe ShiftSubtitle do
  describe "#shift" do
    it 'shifts 01:31:51,210' do
      ShiftSubtitle::shift("01:31:51,210", 2500).should == "01:31:53,710"
    end

    it 'shifts 01:32:07,769' do
      ShiftSubtitle::shift("01:32:07,769", 2500).should == "01:32:10,269"
    end
  end

  describe "shift subs from text" do
    it 'outputs shifted subs' do
      amount = 2500
      ShiftSubtitle::shift_stream(sample_subs, amount).should == shifted
    end
  end

  #describe "command line" do
    #it 'executes command line app' do
      #command = "shift_subtitle --operation sub --time 02,500 subs.srt output_file"
      #system("bin/#{command}")
    #end
  #end
end
