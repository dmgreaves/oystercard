require 'journey'
require 'oystercard'

describe 'in_journey?' do
  it { is_expected.to respond_to :in_journey? }
  it 'checks if a journey is taking place' do
    card2.touch_in
    expect(card2.in_journey?).to eq true
  end
end

describe '#journeys' do
  card3 = Oystercard.new(90)
  it 'card has an empty list of journey history at start' do
    expect(card3.journeys).to be_empty
  end

  it 'touch in and out creates one journey' do
    card3.touch_in('Finsbury Park')
    card3.touch_out(3, 'Oxford Street')
    expect(card3.journeys).to eq [{"entry station" => "Finsbury Park", "exit station" => "Oxford Street"}]
  end
end
