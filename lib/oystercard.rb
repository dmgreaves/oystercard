class Oystercard

attr_reader :balance, :limit

def initialize(balance = 0)
  @balance = balance
  @limit = 90
end

def top_up(amount)
  fail "Reached top up limit of 90" if (@balance += amount) >= 90
  @balance
end


end
