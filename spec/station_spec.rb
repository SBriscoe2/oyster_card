require 'station'

describe Station do
  subject(:station) { described_class.new('Selhurst', 4) }

  context '#initialize checks'
  it 'expects to return the station name' do
    expect(subject.name).to eq 'Selhurst'
  end

  it 'expects to return the zone' do
    expect(subject.zone).to eq 4
  end
end
