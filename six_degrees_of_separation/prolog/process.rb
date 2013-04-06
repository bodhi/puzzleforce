tweets = File.readlines ARGV.first

tweets.collect do |line|
  author, text = line.split(":", 2)
  
  puts "active(#{author})."
                 
  text.scan(/@(\w+)/).flatten.each do |ref|
    puts "mentions(#{author}, #{ref})."
  end
end
