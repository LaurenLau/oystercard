require 'journey'

describe Journey do

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  describe '#start' do
    it 'can get an entry station' do
      subject.start(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe '#exit' do
    it 'can get an exit station' do
      subject.finish(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end
  end
  
  describe '#fare' do
    it 'can produce a fare' do
      subject.start(entry_station)
      subject.finish(exit_station)     
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end
  

    it 'produces a penalty fare when if no entry station' do
      subject.finish(exit_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
  end

  describe '#complete?' do
    it 'returns false for incomplete journey' do
      subject.start(entry_station)
      expect(subject).not_to be_complete
    end
    
    it 'can confirm a journey is complete' do
      subject.finish(exit_station)      
      expect(subject).to be_complete
    end
  end
end