class Oystercard

attr_reader :balance, :limit, :in_journey

  def initialize(balance = 0)
    @balance = balance
    @limit = 90
    @in_journey = false
    @minimum = 1
  end

  def top_up(amount)
    fail "Reached top up limit of 90" if (@balance += amount) >= 90
    @balance
  end

  def pay(fair)
    fail "Insuficient funds" if (@balance -= fair) <= 0
    @balance
  end

  def touch_in
    fail 'Insufficient funds' if @balance <= @minimum
    fail 'Card already in use' if @in_journey == true
    @in_journey = true
  end

  def touch_out(fair)
    pay(fair) if @in_journey == true
    @in_journey = false
  end

end
