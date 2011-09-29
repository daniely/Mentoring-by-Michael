require 'ruby-debug'

class ImageEditor
  DEFAULT_COLOR = 'O'

  attr_reader :image, :output

  def initialize(output=STDOUT)
    @output = output
  end

  def to_s
    @image.map{ |i| i.join }.join("\n")
  end

  def execute(input)
    commands = input.split

    case commands.shift
    when "I"
      width = commands.shift.to_i
      height = commands.shift.to_i

      if width < 1 || height < 1 || width > 250 || height > 250
        @output.puts "Image must be 1 <= m,n <= 250" 
        return
      end

      @image = []
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
    when "F"
      x = commands.shift.to_i
      y = commands.shift.to_i
      new_color = commands.shift
      old_color = @image[y][x]

      fill(x, y, old_color, new_color)
    when "C"
      execute("I #{@image.first.size} #{@image.size}")
    when "S"
      @output.puts to_s
    else
      @output.puts "Bad command. Please try again."
    end
  end

  def fill(x, y, old_color, new_color)
    # exit if already colored
    return if @image[y][x] == new_color

    execute("L #{x.next} #{y.next} #{new_color}")

    # get valid adjacent pts
    adjacent_coords = [x-1, x+1].product([y]) + [x].product([y-1, y+1])
    adjacent_coords.delete_if{ |c| c.first < 0 || c.last < 0 }
    adjacent_coords.delete_if{ |c| c.first > @image.first.size - 1 || c.last > @image.size - 1 }

    # remove if color doesn't match
    adjacent_coords.delete_if{ |c| @image[c.last][c.first] != old_color }

    adjacent_coords.each { |a| fill(*a, old_color, new_color) }
  end
end
