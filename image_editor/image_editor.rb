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
    input = input.split

    case input.shift
    when "I"
      width = input.shift.to_i
      height = input.shift.to_i

      if width < 1 || height < 1 || width > 250 || height > 250
        @output.puts "Image must be 1 <= m,n <= 250" 
        return
      end

      @image = []
      height.times { @image << [DEFAULT_COLOR] * width }
    when "V"
      x = input.shift.to_i
      y1 = input.shift.to_i
      y2 = input.shift.to_i
      color = input.shift

      (y1..y2).each { |y| @image[y-1][x-1] = color }
    when "H"
      x1 = input.shift.to_i
      x2 = input.shift.to_i
      y = input.shift.to_i
      color = input.shift

      (x1..x2).each { |x| @image[y-1][x-1] = color }
    when "L"
      x = input.shift.to_i
      y = input.shift.to_i
      color = input.shift

      @image[y-1][x-1] = color
    when "F"
      x = input.shift.to_i
      y = input.shift.to_i
      new_color = input.shift
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
