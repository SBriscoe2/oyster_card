require 'station'

describe Station do

  context '#initialize checks'
  it 'expects to return the station name' do
    subject = Station.new("Selhurst", 4)
    expect(subject.name).to eq ("Selhurst")
  end

  it 'expects to return the zone' do
    subject = Station.new("Selhurst", 4)
    expect(subject.zone).to eq (4)
  end
end
