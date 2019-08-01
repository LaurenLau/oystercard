require 'station'

describe Station do

  subject { Station.new("Old Street", 1) }

  it { is_expected.to respond_to(:name, :zone) }

end