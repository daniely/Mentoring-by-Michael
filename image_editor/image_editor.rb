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
    when "F"
      x = commands.shift.to_i
      y = commands.shift.to_i
      new_color = commands.shift
      old_color = @image[y][x]

      fill(x, y, old_color, new_color)
    when "C"
      execute("I #{@image.first.size} #{@image.size}")
    when "S"
      @image.map!{ |a| a.join }.join("\n")
    end
  end

  def fill(x, y, old_color, new_color, marked_coords=[])
    if marked_coords.include?([x, y])
      return
    else
      marked_coords << [x, y]
    end

    execute("L #{x.next} #{y.next} #{new_color}")

    # get valid adjacent pts
    adjacent_coords = [x-1, x+1].product([y]) + [x].product([y-1, y+1])
    adjacent_coords.delete_if{ |c| c.first < 0 || c.last < 0 }
    adjacent_coords.delete_if{ |c| c.first > @image.first.size - 1 || c.last > @image.size - 1 }

    # remove if color doesn't match
    adjacent_coords.delete_if{ |c| @image[c.last][c.first] != old_color }

    adjacent_coords.each { |a| fill(*a, old_color, new_color, marked_coords) }
  end
end
