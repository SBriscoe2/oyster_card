# frozen_string_literal: true

class Oystercard
  attr_reader :balance
  attr_reader :entry_station

  TOP_UP_MAX = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0

  end

  def top_up(top_up_value)
    raise "Balance exceeds #{TOP_UP_MAX}" if \
      @balance + top_up_value > TOP_UP_MAX

    @balance += top_up_value
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise 'Insufficient funds' if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct MINIMUM_BALANCE
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
