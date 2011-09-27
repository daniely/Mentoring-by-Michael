require 'ruby-debug'

class ImageEditor
  DEFAULT_COLOR = 'O'

  attr_reader :image

  def execute(input)
    commands = input.split
    command = commands.shift

    case command
    when "I"
      @image = []
      width = commands.shift.to_i
      height = commands.shift.to_i

      height.times { @image << ['O'] * width }
    when "V"
      x = commands.shift.to_i
      y1 = commands.shift.to_i
      y2 = commands.shift.to_i
      color = commands.shift

      (y1..y2).each do |y|
        @image[y-1][x-1] = color
      end
    when "H"
      x1 = commands.shift.to_i
      x2 = commands.shift.to_i
      y = commands.shift.to_i
      color = commands.shift

      (x1..x2).each do |x|
        @image[y-1][x-1] = color
      end
    when "L"
      x = commands.shift.to_i
      y = commands.shift.to_i
      color = commands.shift

      @image[y-1][x-1] = color
    when "C"
      execute("I #{@image.first.size} #{@image.size}")
    when "S"
      @image.map!{ |a| a.join }.join("\n")
    end
  end
end
