require 'oyster_card'

describe Oystercard do
  subject(:oyster) { described_class.new }
  let(:add_top_up_money) { oyster.top_up(20) }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  min_balance = Oystercard::MINIMUM_BALANCE

  it { is_expected.to respond_to :balance }

  it 'is expected to show a balance of 0' do
    expect(oyster.balance).to eq 0
  end

  context 'topping up' do
    it { is_expected.to respond_to(:top_up).with(1) }

    it 'is expected to show a balance of 40' do
      add_top_up_money
      expect(oyster.top_up(20)).to eq 40
    end

    it 'is expected to show error if top up exceeds 90' do
      max_balance = Oystercard::TOP_UP_MAX
      oyster.top_up(max_balance)
      expect { oyster.top_up(1) }.to \
        raise_error "Balance exceeds #{max_balance}"
    end
  end

  context 'touch in' do
    it 'has not been touched in' do
      expect(oyster.in_journey?).to eq false
    end

    it 'shows card has been touched in' do
      add_top_up_money
      expect { oyster.touch_in(:station) }.to \
        change { oyster.in_journey? }.from(false).to(true)
    end

    it 'does not allow touching in if balance is below the minimum level' do
      expect { oyster.touch_in(:station) }.to raise_error 'Insufficient funds'
    end

    it 'shows the station where the card was touched in' do
      add_top_up_money
      oyster.touch_in(:station)
      expect(oyster.entry_station).to eq :station
    end
  end

  context 'touching out' do
    it 'shows card has been touched out' do
      add_top_up_money
      oyster.touch_in(:station)
      expect { oyster.touch_out(:station) }.to \
        change { oyster.in_journey? }.from(true).to(false)
    end

    it 'charges the minimum balance when the card is touched out' do
      add_top_up_money
      oyster.touch_in(:station)
      expect { oyster.touch_out(:station) }.to \
        change { oyster.balance }.by(-min_balance)
    end

    it 'it forgets the entry station when the card is touched out' do
      add_top_up_money
      oyster.touch_in(:station)
      oyster.touch_out(:station)
      expect(oyster.touch_out(:station)).to eq nil
    end

    it 'show the station where the card was touched out' do
      add_top_up_money
      oyster.touch_in(:station)
      oyster.touch_out(:station)
      expect(oyster.exit_station).to eq :station
    end
  end

    it 'checks on initialize that journey list is empty' do
      expect(oyster.journey_list).to be_empty
    end

    it 'checks that the entry and exit station are stored as one journey' do
      add_top_up_money
      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
      expect(oyster.journey_list).to eq [{ entry_station => exit_station }]
    end
end
