class Character
  attr_accessor :name

  def name=(n)
    @name = "called name= method"
  end

  def call_name_no_self(n)
    name = n # fails to call name= method
    p @name
  end

  def call_name_with_self(n)
    self.name = n # correct way to call name= method
    p @name
  end
end

p "show the diff between calling 'self.name' and 'name'"
c = Character.new
p "call 'name'"
c.call_name_no_self("Ginrush")

p "call 'self.name'"
c.call_name_with_self("Ginrush")
