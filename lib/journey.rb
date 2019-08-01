class Journey

  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 2
  PENALTY_FARE = 6
  def initialize
    @complete = false
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
    @complete = true
  end

  def fare
    return PENALTY_FARE if !@entry_station || !@exit_station
   MINIMUM_FARE 
  end

  def complete?
    @complete
  end

end
