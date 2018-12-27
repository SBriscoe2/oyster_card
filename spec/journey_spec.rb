require 'journey'

describe Journey do
  subject(:journey) { described_class.new entry_station: nil }

  it 'expects entry_station to be nil on initialize' do
    expect(subject.entry_station).to be nil
  end
end
