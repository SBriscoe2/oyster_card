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
    expect(subject.top_up(20)).to eq 40
  end

  it 'is expected to show error if top up exceeds 90' do
    max_balance = Oystercard::TOP_UP_MAX
    subject.top_up(max_balance)
    expect { subject.top_up(max_balance)}.to raise_error "Balance exceeds #{max_balance}"
  end
end
