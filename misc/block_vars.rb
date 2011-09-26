def block_var
  x = "hello"
  3.times do |i, x|
    x = i*2
    puts "#{i} #{x}"
  end
  puts x
end

block_var
