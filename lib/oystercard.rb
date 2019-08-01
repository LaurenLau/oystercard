
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1.5
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys 

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount 
  end

  def in_journey?
    !!entry_station
  end
  
  def touch_in(station)
    fail "Please top up to touch in" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    @journeys << { entry: @entry_station, exit: @exit_station }
    @exit_station = @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
  
end
