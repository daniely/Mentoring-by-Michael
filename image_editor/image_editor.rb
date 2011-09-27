require 'ruby-debug'

class ImageEditor
  attr_reader :image

  def initialize
    @image = []
  end

  def execute(commands)
    5.times { @image << [*1..6] }
  end
end
