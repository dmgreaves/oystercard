class Oystercard

attr_reader :balance, :limit, :in_journey, :entry_station, :journeys

  def initialize(balance = 0)
    @balance = balance
    @limit = 90
    @minimum = 1
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Reached top up limit of #{@limit}" if (@balance += amount) >= @limit
    @balance
  end

  def touch_in(entry_station = "none")
    fail 'Insufficient funds' if @balance <= @minimum
    fail 'Card already in use' if in_journey?

    @journey = Hash.new
    @journey["entry station"] = entry_station
    @entry_station = entry_station
  end

  def touch_out(fair, exit_station = "none")
    pay(fair) if in_journey?
    @journey["exit station"] = exit_station
    @journeys << @journey
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def pay(fair)
    fail "Insuficient funds" if (@balance -= fair) <= 0
    @balance
  end

end
