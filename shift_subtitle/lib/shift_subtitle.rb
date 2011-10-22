require 'time'
require 'ruby-debug'

class ShiftSubtitle
  attr_reader :subs_file, :new_file, :amount

  def initialize(subs_file, new_file, amount)
    @subs_file = subs_file
    @new_file = new_file
    @amount = amount
  end

  def shift_file
    file_text = ''
    File.open(subs_file, 'r'){ |f| file_text = f.read }
    shifted_text = ShiftSubtitle::shift_stream(file_text, amount)

    File.open(new_file, 'w'){ |f| f.write shifted_text }
  end

  def self.shift_stream(stream, amount)
    result = []

    stream.each_line do |line|
      if line.match(/\d{2}:\d{2}:\d{2},\d{2}/)
        start, finish = line.split(' --> ')
        result << "#{ShiftSubtitle::shift(start, amount)} --> #{ShiftSubtitle::shift(finish, amount)}\n"
      else
        result << line
      end
    end

    result.join
  end

  def self.shift(time, amount)
    parsed_time = Time.parse(time)
    amount_in_seconds = amount / 1000.0
    result = parsed_time + amount_in_seconds

    "#{result.strftime('%H:%M:%S')},#{result.usec.to_s[0..2]}"
  end
end
