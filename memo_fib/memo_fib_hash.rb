fib = Hash.new do |h, k|
  h[k] = h[k-1] + h[k-2]
end
fib.merge!({ 0 => 0, 1 => 1 })

puts "fib 6 is #{fib[6]}"
p fib
