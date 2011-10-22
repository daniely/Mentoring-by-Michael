require 'time'
require 'ruby-debug'

module ShiftSubtitle
  def self.shift_stream(stream, amount)
    result = ''

    stream.each_line do |line|
      if line.match(/\d{2}:\d{2}:\d{2},\d{2}/)
        start, finish = line.split(' --> ')
        result << "#{ShiftSubtitle::shift(start, amount)} --> #{ShiftSubtitle::shift(finish, amount)}\n"
      else
        result << line
      end
    end

    result
  end

  def self.shift(time, amount)
    parsed_time = Time.parse(time)
    amount_in_seconds = amount / 1000.0
    result = parsed_time + amount_in_seconds

    "#{result.strftime('%H:%M:%S')},#{result.usec.to_s[0..2]}"
  end
end
