require 'journey'
require 'oystercard'
describe Journey do
  let (:station) {Station.new("Angel",5) }

  describe 'in_journey?' do
    it 'checks if a journey is taking place' do
      card = Oystercard.new(10,journey = Journey.new)
      card.touch_in(station)
      expect(journey.in_journey?).to eq true
    end
  end

  describe '#journeys' do
    card3 = Oystercard.new(90)
    it 'card has an empty list of journey history at start' do
      expect(card3.history).to eq []
    end

    it 'touch in and out creates one journey' do
      card3.touch_in('Finsbury Park')
      card3.touch_out('Oxford Street')
      expect(card3.history).to eq [{"entry station" => "Finsbury Park", "exit station" => "Oxford Street"}]
    end
    it 'registers a station on touch in' do
      subject.set_entry_station("Finsbury Park")
      expect(subject.entry_station).to eq "Finsbury Park"
    end
  end

  describe '#fare' do
    it 'deducts a standard fare if there is a complete journey' do
      subject.set_entry_station(station)
      expect(subject.fare).to eq 1
    end

    it 'deducts a penalty fare (£6) when you fail to touch in' do
      subject.exit_station(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'deducts a Penalty fare when you touch_in after failing to touch out on a previous journey' do
      subject.set_entry_station(station)
      subject.set_entry_station(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end
