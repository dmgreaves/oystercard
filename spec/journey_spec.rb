require 'journey'
require 'oystercard'
describe Journey do
  describe 'in_journey?' do

    let (:station) {Station.new("Angel",5) }
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
    it 'deducts a standard fare if there is a complete journey' do
      expect(subject.fare).to eq 1
    end
  end
end
