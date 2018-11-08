require 'journey'

describe Journey do

  it 'expects entry_station to be nil on initialize' do
    subject = Journey.new(entry_station: nil)
    expect(subject.entry_station).to be nil
  end

end
