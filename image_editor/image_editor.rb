require 'ruby-debug'

class ImageEditor
  DEFAULT_COLOR = 'O'

  attr_reader :image

  def initialize
    @image = []
  end

  def execute(input)
    commands = input.split
    command = commands.shift

    case command
    when "I"
      width = commands.shift.to_i
      height = commands.shift.to_i
      height.times do
        @image << Marshal::load(Marshal.dump(DEFAULT_COLOR * width))
      end
    when "L"
      x = commands.shift.to_i
      y = commands.shift.to_i
      color = commands.shift
      @image[y-1][x-1] = color
    when "S"
      @image.join("\n")
    end
  end
end
