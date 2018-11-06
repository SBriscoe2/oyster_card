require 'oyster_card'

describe Oystercard do
  it { is_expected.to respond_to :balance }
end

describe Oystercard do
  it 'is expected to show a balance of 0' do
    expect(subject.balance).to eq 0
  end
end
