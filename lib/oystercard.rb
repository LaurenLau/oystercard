require_relative './journey.rb'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :in_journey, :journeys, :journey

  def initialize(journey_class = Journey)
    @balance = 0
    @journey_class = journey_class
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    return false if !@journey
    !journey.complete?
  end
  
  def touch_in(station)
    fail "Please top up to touch in" if balance < MINIMUM_BALANCE
    @journey = @journey_class.new # == Journey.new by default
    journey.start(station)
  end

  def touch_out(station)
    journey.finish(station)
    deduct(journey.fare)
    journeys << journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end
  
end

# Single responsibility principle
# The oystercard class is responsible for touching in and out and maintaining the balance
