# prefers going down
# then going right
data = File.readlines(ARGV.first)
water = data.shift.to_i; data.shift

# remove cap and floor
data.shift; data.pop
height = data.length
width = data.first.length

data = data.collect {|r| r.split "" }.transpose

leak = lambda {
  col = data.find { |col| col.include?(" ") }
  r = col.index " "
  col[r] = "~"
}

print = lambda { 
  puts "#" * (width - 1)
  puts data.transpose.collect(&:join).join
  puts "#" * (width - 1)
  puts
}

#require "pry"
#binding.pry

water.times { 
  print[]
  sleep 0.2
  leak[] 
}
