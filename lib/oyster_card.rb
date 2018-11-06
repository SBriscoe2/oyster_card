# frozen_string_literal: true
class Oystercard
  attr_reader :balance

  TOP_UP_MAX = 90

  def initialize
    @balance = 0
  end

  def top_up(top_up_value)
    fail "Balance exceeds #{TOP_UP_MAX}" if @balance + top_up_value > TOP_UP_MAX
    
    @balance += top_up_value
  end
end
