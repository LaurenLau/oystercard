class Journey
  
  attr_reader :entry_station, :exit_station

  def initialize
    @complete = false
  end

  def start(station)
    @entry_station = station
    @complete = false
  end

  def finish(station)
    @exit_station = station
    @complete = true
  end

  def fare
   2
  end

  def complete?
    @complete
  end

end