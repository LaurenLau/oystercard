require 'oystercard'

describe Oystercard do

  let(:max_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:min_balance) { Oystercard::MINIMUM_BALANCE }
  let(:min_charge) { Oystercard::MINIMUM_CHARGE }
  
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  let(:DoubleJourneyClass) { 
    double("DoubleJourneyClass",
    :new => double(
      "DoubleJourney",
      :start => "has started",
      :finish => "has finished",
      :fare => 2,
      :complete? => true
      )
    ) 
    subject { Oystercard.new(DoubleJourneyClass) }
  }

  let(:journey) { DoubleJourneyClass.new }


  it 'initially has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  
  it 'initially has an empty journey list' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a list of journeys' do
    subject { Oystercard.new(DoubleJourneyClass) }
    subject.top_up(min_balance)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    journey = subject.journey
    expect(subject.journeys).to include journey
  end

  describe '#top_up' do 
    it 'can top up the balance' do 
      expect{ subject.top_up(min_balance) }.to change{ subject.balance }.by(min_balance)
    end
  
    it 'raises an error when top up limit reached' do
      subject.top_up(max_balance)
      expect { subject.top_up(min_balance) }.to raise_error "Maximum balance of #{max_balance} exceeded"
    end
  end

  describe '#touch_in' do

    it 'has a minimum balance to touch_in' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Please top up to touch in"
    end
  end

  describe '#touch_out' do
  
    it 'deducts fare upon touching out' do
      subject.top_up(max_balance)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Journey::MINIMUM_FARE)
    end
  end

  describe '#in_journey' do

    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'is in journey after touch in' do
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'is not in journey after touch out' do
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    
  end

end