class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :journey_list
  attr_reader :exit_station

  TOP_UP_MAX = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey_list = []
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

  def journey
    @journey_list
  end

  def touch_out(station)
    deduct MINIMUM_BALANCE
    @exit_station = station
    @journey_list << { entry_station => exit_station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
