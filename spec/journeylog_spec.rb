require 'journeylog'

describe JourneyLog do

  it 'initially has an empty journey list' do
    expect(subject.journeys).to be_empty
  end
  
end
