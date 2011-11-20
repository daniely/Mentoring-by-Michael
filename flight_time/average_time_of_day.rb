require 'ruby-debug'
require 'time'

DAY_IN_SECONDS = 24 * 60 * 60

def average_time_of_day(times)
  # sum diff of each from arrival_time
  # div by # of elements
  # add to arrival_time

  meridian = @arrival_time.match(/[ap]m/)[0]

  avg_time_diff = times.map! do |t|
    i_time = Time.parse(t)
    i_time += DAY_IN_SECONDS unless t.match(meridian)
    i_time - Time.parse(@arrival_time)
  end.inject(:+) / times.size

  (Time.parse(@arrival_time) + avg_time_diff).strftime('%l:%M%p').strip.downcase
end

describe "average_time_of_day" do
  it '12:01am' do
    @arrival_time = "10pm"
    average_time_of_day(["11:51pm", "11:56pm", "12:01am", "12:06am", "12:11am"]).should == "12:01am"
  end

  it '6:51am' do
    @arrival_time = "10pm"
    average_time_of_day(["6:41am", "6:51am", "7:01am"]).should == "6:51am"
  end

  it '10:33pm' do
    @arrival_time = "10pm"
    average_time_of_day(["10:20pm", "10:30pm", "10:50pm"]).should == "10:33pm"
  end

  it '6:33am' do
    @arrival_time = "10pm"
    average_time_of_day(["10:20am", "10:30am", "10:50pm"]).should == "6:33am"
  end

end
