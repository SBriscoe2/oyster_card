# frozen_string_literal: true

class Oystercard
  attr_reader :balance

  TOP_UP_MAX = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(top_up_value)
    raise "Balance exceeds #{TOP_UP_MAX}" if \
      @balance + top_up_value > TOP_UP_MAX

    @balance += top_up_value
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise 'Insufficient funds' if @balance < MINIMUM_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end
end
