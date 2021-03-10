require_relative 'oystercard'

class Journey

  def initialize
    @journeys = []
  end

  def entry_station(station)
    @journey = Hash.new
    @journey["entry station"] = station
    @entry_station = station
  end

  def exit_station(station)
    @journey["exit station"] = station
    @journeys << @journey
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

end
