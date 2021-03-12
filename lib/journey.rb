require_relative 'oystercard'

class Journey
  attr_reader :entry_station

  PENALTY_FARE = 6

  def initialize
    @journeys = []
    @journey = Hash.new
  end

  def set_entry_station(station)
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
    if in_journey?
      return 1
    elsif !in_journey?
      return PENALTY_FARE
    end

    # (in_journey? && @journey['exit_station'] == nil) ? 1 : PENALTY_FARE
  end

  private

  def completed_journey?
    @journeys["entry station"] != nil &&  @journeys["exit station"] != nil
  end

end
