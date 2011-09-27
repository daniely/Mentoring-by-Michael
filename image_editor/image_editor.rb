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
      @image = [DEFAULT_COLOR * width] * height
    end
  end
end
