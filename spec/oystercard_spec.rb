require 'oystercard'

describe Oystercard do

    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end

  describe '#top_up' do 
    it 'can top up the balance' do 
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

    it 'raises an error when top up limit reached' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end
   
  describe '#deduct' do 
    it 'can deduct fare' do
      subject.deduct(10)
      expect{ subject.deduct(5) }.to change{ subject.balance }.by(-5)
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
