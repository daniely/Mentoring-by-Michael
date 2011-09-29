require './image_editor'

def run_editor
  prompt = "Commands: I M N, C, L X Y C, V X Y1 Y2 C, H X1 X2 Y, F X Y C, S X"
  puts prompt
  ie = ImageEditor.new

  while (input = gets.chomp) != 'x'
    ie.execute(input)
  end
end

run_editor
