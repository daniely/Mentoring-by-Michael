require 'pry'

class Commands
  attr_reader :commands

  def initialize
    @commands = {}
    %w[i v h l f c s].each do |letter|
      @commands[letter] = public_method("command_#{letter}")
    end
  end

  def command_i(ie, input)
    width = input.shift.to_i
    height = input.shift.to_i

    if width < 1 || height < 1 || width > 250 || height > 250
      ie.output.puts "Image must be 1 <= m,n <= 250"
      return
    end

    ie.image = []
    height.times { ie.image << [ImageEditor::DEFAULT_COLOR] * width }
  end

  def command_v(ie, input)
    x = input.shift.to_i
    y1 = input.shift.to_i
    y2 = input.shift.to_i
    color = input.shift

    (y1..y2).each { |y| ie.image[y-1][x-1] = color }
  end

  def command_h(ie, input)
    x1 = input.shift.to_i
    x2 = input.shift.to_i
    y = input.shift.to_i
    color = input.shift

    (x1..x2).each { |x| ie.image[y-1][x-1] = color }
  end

  def command_l(ie, input)
    x = input.shift.to_i
    y = input.shift.to_i
    color = input.shift

    ie.image[y-1][x-1] = color
  end

  def command_f(ie, input)
    x = input.shift.to_i
    y = input.shift.to_i
    new_color = input.shift
    old_color = ie.image[y][x]

    fill(ie, x, y, old_color, new_color)
  end

  def command_c(ie, input)
    command_i(ie, [ie.image.first.size, ie.image.size])
  end

  def command_s(ie, input)
    ie.output.puts ie.to_s
  end

  private

  def fill(ie, x, y, old_color, new_color)
    # exit if already colored
    return if ie.image[y][x] == new_color

    command_l(ie, [x.next, y.next, new_color])

    # get valid adjacent pts
    adjacent_coords = [x-1, x+1].product([y]) + [x].product([y-1, y+1])
    adjacent_coords.delete_if{ |c| c.first < 0 || c.last < 0 }
    adjacent_coords.delete_if{ |c| c.first > ie.image.first.size - 1 || c.last > ie.image.size - 1 }

    # only fill if color is the same
    adjacent_coords.delete_if{ |c| ie.image[c.last][c.first] != old_color }

    adjacent_coords.each { |a| fill(ie, *a, old_color, new_color) }
  end
end

class ImageEditor
  DEFAULT_COLOR = 'O'

  attr_accessor :image, :output, :commands

  def initialize(output=STDOUT)
    @output = output
    @commands = Commands.new.commands
    @image = []
  end

  def add_command(key, &block)
    commands[key] = block
  end

  def to_s
    @image.map{ |i| i.join }.join("\n")
  end

  def execute(input)
    input = input.split

    command = input.shift
    commands[command.downcase].call(self, input)
  rescue NoMethodError => ex
    puts "Sorry, command #{command} does not exist"
  end
end
