class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end
  
end

# Single responsibility principle
# The station class is responsible for having a name and a zone 
