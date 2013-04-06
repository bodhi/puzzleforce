class Node
  attr_accessor :state, :down, :right
  
  def initialize state
    @state = state
  end

  def to_s
    state + right.to_s
  end

  def empty?
    state == " "
  end

  def expand
    @state = "~"
    ex = []
    ex << down if down and down.empty?
    ex << right if right and right.empty?
  end

  def score accum = 0
    if state == " " and accum > 0
      "~"
    elsif down
      inc = state == "~" ? 1 : 0
      down.score accum + inc
    else
      accum
    end
  end
end

data = File.read(ARGV.first).split("\n")
water = data.shift.to_i - 1; data.shift

top = nil

nodes = []

data.each { |row|
  nodes << node_row = []
  row.split("").each {|c|
    node = Node.new(c)
    top ||= node
    node_row << node
  }
}

# Link row nodes together
nodes.each { |row|
  left = nil
  row.each { |node| 
    left.right = node if left
    left = node
  }
}

# Link column nodes together
nodes.transpose.each { |col|
  up = nil
  col.each { |node|
    up.down = node if up
    up = node
  }
}

p_scores = lambda {
  node = top
  scores = []
  while node
    scores << node.score
    node = node.right
  end
  puts scores.join " "
}

print = lambda { 
  n = top
  while n
    puts n.to_s
    n = n.down
  end
 
#  p_scores[]
}

open = top.down.expand # water always here

water.times do
  break if open.empty?
  node = open.shift
  open.unshift *(node.expand)

  print[]
end

p_scores[]
