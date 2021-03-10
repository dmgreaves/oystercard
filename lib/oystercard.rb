require_relative 'station'

class Oystercard

attr_reader :balance, :limit, :in_journey, :entry_station, :journeys

  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @limit = 90
    @minimum = 1
    @entry_station = nil
    @journey = journey
  end

  def top_up(amount)
    fail "Reached top up limit of #{@limit}" if (@balance += amount) >= @limit
    @balance
  end

  def touch_in(entry_station = "none")
    fail 'Insufficient funds' if @balance <= @minimum
    fail 'Card already in use' if @journey.in_journey?
    @journey.set_entry_station(entry_station)
  end

  def touch_out(exit_station = "none", fair = 2)
    pay(fair) if @journey.in_journey?
    @journey.exit_station(exit_station)
  end

  def history
    @journey.history
  end

  private

  def pay(fair)
    fail "Insuficient funds" if (@balance -= fair) <= 0
    @balance
  end

end
