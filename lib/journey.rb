require_relative 'oystercard'

class Journey
  attr_reader :entry_station

  def initialize
    @journeys = []
  end

  def set_entry_station(station)
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

  def history
    @journeys
  end

  def fare
    1
  end

end
