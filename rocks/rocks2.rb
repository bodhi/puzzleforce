data = File.readlines(ARGV.first)
water = data.shift.to_i; data.shift

# remove cap and floor
data.shift; data.pop

height = data.length
width = data.first.length

data = data.collect {|r| r.split "" }.transpose

print = lambda { 
  puts "#" * (width - 1)
  puts data.transpose.collect(&:join).join
  puts "#" * (width - 1)
}

drop = lambda { |column| 
  k = data[column]
  i = k.reverse.index " " # find empty space
}

settle_col = lambda { |col|
  col = col.reverse
  new = []
  # move ground
  new.unshift col.shift while col.first == "#"

  # drop water
  col.shift if col.first == " "

  new.unshift col.shift until col.empty?

  new.unshift " " while new.length < height

  new
}

settle = lambda { |data|
  data.collect { |col|
    settle_col col
  }
}

require "pry"
#binding.pry

data = settle[data]

print[]
