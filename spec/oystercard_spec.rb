# frozen_string_literal: true

require 'oyster_card'

describe Oystercard do
  let(:add_top_up_money) { subject.top_up(20) }

  it { is_expected.to respond_to :balance }

  it 'is expected to show a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1) }

  it 'is expected to show a balance of 40' do
    add_top_up_money
    expect(subject.top_up(20 )).to eq 40
  end

  it 'is expected to show error if top up exceeds 90' do
    max_balance = Oystercard::TOP_UP_MAX
    subject.top_up(max_balance)
    expect { subject.top_up(1) }.to raise_error "Balance exceeds #{max_balance}"
  end

  it 'is expected to deduct a balance of 10' do
    add_top_up_money
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  it 'has not been touched in' do
    expect(subject.in_journey?).to eq false
  end

  it 'shows card has been touched in' do
    expect { subject.touch_in }.to change { subject.in_journey? }.from(false).to(true)
  end

  it 'shows card has been touched out' do
    subject.touch_in
    expect { subject.touch_out }.to change { subject.in_journey? }.from(true).to(false)
  end

end
