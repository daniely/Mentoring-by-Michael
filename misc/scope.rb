class Sword
  name = "1h sword"

  def attack
    #puts name # errors here saying undefined local var or method
    name = "morning star"
    puts name
  end
end

s = Sword.new
s.attack
