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

      fill_coords(0, 0, old_color, new_color)
    when "C"
      execute("I #{@image.first.size} #{@image.size}")
    when "S"
      @image.map!{ |a| a.join }.join("\n")
    end
  end

  # change pixel color
  # check if adjacent is diff color
  #   is adjacent point within range?
  #     no, remove it
  #   diff and within range, then change color
  def fill_coords(y, x, old_color, new_color, marked_coords=[])
    if marked_coords.include?([y, x])
      return
    else
      marked_coords << [y, x]
    end

    execute("L #{x.next} #{y.next} #{new_color}")

    # get valid adjacent pts
    adjacent_coords = [y-1, y+1].product([x]) + [y].product([x-1, x+1])
    adjacent_coords.delete_if{ |c| c[0] < 0 || c[1] < 0 }
    adjacent_coords.delete_if{ |c| c[0] > 5 || c[1] > 5 }

    # remove if color doesn't match
    adjacent_coords.delete_if{ |c| @image[c.first][c.last] != old_color }

    # delete if color already changed
    adjacent_coords = adjacent_coords - marked_coords

    adjacent_coords.each { |a| fill_coords(*a, old_color, new_color, marked_coords) }
  end
end
