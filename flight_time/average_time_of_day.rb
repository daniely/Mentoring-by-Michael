require 'ruby-debug'
require 'time'

SECS_PER_DAY = 24 * 60 * 60

def average_time_of_day(times)
  # sum diff of each from arrival_time
  # div by # of elements
  # add to arrival_time

  meridian = @arrival_time.match(/[ap]m/)[0]

  avg_time_diff = times.map! do |t|
    i_time = Time.parse(t)
    i_time += SECS_PER_DAY unless t.match(meridian)
    i_time - Time.parse(@arrival_time)
  end.inject(:+) / times.size

  Time.parse(@arrival_time) + avg_time_diff
end

describe "average_time_of_day" do
  it 'calculate avg arrival time' do
    @arrival_time = "10pm"
    average_time_of_day(["11:51pm", "11:56pm", "12:01am", "12:06am", "12:11am"]).should == "12:01am"
  end
end
