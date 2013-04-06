# http://puzzlenode.com/puzzles/11-hitting-rock-bottom

require "pry"

# flow left
# flow right
# flow up

###########
#0,0   x,0#
#         #
#0,y,  x,y#
###########

class Room
  def initialize data = nil
    @hor = 0...data.first.length
    @ver = 0...data.length
    @data = data
  end

  def fill! x, y, content = "~"
    if @hor.include?(x) and 
        @ver.include?(y) and 
        (@data[y][x] == " " or !@data[y][x])
      @data[y][x] = content
    end
  end

  def to_s
    @data
  end
end

def room
  @room
end

#def flow x, y
#  [x,y] if room.fill!(x, y)
#end


data = File.readlines(ARGV.first)
water = data.shift.to_i; data.shift

width = data.first.length
@room = Room.new(data)

#@room = Room.new(5, 5)
#@room.fill!(0, 2, "#")
#@room.fill!(3, 3, "#")

x,y = 0, 1

view = lambda do
  puts "#{x},#{y}"
  puts @room.to_s
  puts "-" * 10
end

view[]

leak = lambda do
  view[]
  x,y = flow(x, y + 1) || flow(x + 1, y) || flow(x - 1, y) || flow(x, y - 1)
end

water.times do
  begin
    leak[]
    break unless x 
    sleep 0.1
  rescue
#    binding.pry
  end
end
