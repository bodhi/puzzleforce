require "set"

def parse tweets
  tweets.collect do |line|
    author, text = line.split(":", 2)
    references = text.scan(/@(\w+)/).flatten

    [author, references]
  end
end

class Person
  attr_accessor :name, :connections
  def initialize name
    @name = name
    @connections = Set.new
  end

  def connected_to? person
    @connections.include? person
  end

  def directly_connected_to? person
    connected_to?(person) and person.connected_to?(self)
  end

  def connect_to person
    @connections.add(person)
  end

  def direct_connections
    connections.select { |p| p.connected_to? self }
  end

  def inspect
    "#<#{name} (connected to #{connections.collect(&:name).join ", "})>"
  end

  def to_s
    name
  end
end

def graph data
  people = Hash.new { |h,k| h[k] = Person.new(k) }

  data.each do |author, refs|
    refs.each { |name| people[author].connect_to people[name]  }
  end

  people
end

def connections people, ignore = []
  direct = people.collect { |person| person.direct_connections }.flatten.reject { |person| ignore.include? person }.uniq.sort_by(&:name)
  puts direct.join ", " unless direct.empty?
  
  connections direct, ignore + direct unless direct.empty?
end

def analyse people
  people.keys.sort.each do |name|
    person = people[name]
    next if person.connections.empty?
    puts person
    connections [person], [person]
    puts
  end
end

tweets = File.readlines ARGV.first
analyse(graph(parse(tweets)))
