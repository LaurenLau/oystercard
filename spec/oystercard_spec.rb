require 'oystercard'

describe Oystercard do

  max_balance = Oystercard::MAXIMUM_BALANCE
  min_balance = Oystercard::MINIMUM_BALANCE
  min_charge = Oystercard::MINIMUM_CHARGE
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
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
      expect{ subject.touch_in }.to raise_error "Please top up to touch in"
    end
  end

  describe '#touch_out' do
    it 'deducts fare upon touching out' do
      subject.top_up(max_balance)
      expect{ subject.touch_out }.to change{ subject.balance }.by(-min_charge)
    end
  end

  describe '#in_journey' do
    it 'is initially not in journey' do
      expect(subject.in_journey).to eq false
    end

    it 'is in journey after touch in' do
      subject.touch_in
      expect(subject.in_journey).to eq true
    end

    it 'is not in journey after touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
  end

end