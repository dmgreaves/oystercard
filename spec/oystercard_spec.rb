require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new(0) }
  let(:card2) { Oystercard.new(20) }
  it { is_expected.to respond_to :balance }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do

    it 'tops up the card balance with the amount ' do
      expect(card.top_up(10)).to eq 10
      expect(card.balance).to eq 10
    end
  end

  describe '#limit' do

  it { is_expected.to respond_to :limit }
  it 'raises an error if topping up over 90' do
    expect { card.top_up(90) }.to raise_error('Reached top up limit of 90')
  end

  it 'raises an error if the balance exceeds 90' do
    card_with_balance = Oystercard.new(50)
    expect {card_with_balance.top_up(50) }.to raise_error('Reached top up limit of 90')
    end
  end

  describe 'in_journey?' do
    it { is_expected.to respond_to :in_journey? }
    it 'checks if a journey is taking place' do
      card2.touch_in
      expect(card2.in_journey?).to eq true
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to :touch_in }
    # it 'is aware that it is in use' do
    #   expect(card2.touch_in).to eq true
    # end
    it 'cannot touch in when already in use' do
      card2.touch_in
      expect { card2.touch_in }.to raise_error 'Card already in use'
    end
    it 'wont let you touch in if your balance is too low' do
      expect { card.touch_in }.to raise_error 'Insufficient funds'
    end
    it 'registers entry station' do
      card2.touch_in("Oxford Street")
      expect(card2.entry_station).to eq "Oxford Street"
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    # it 'is aware that it is out of use' do
    #   expect(card.touch_out(2.40)).to eq false
    # end
    it 'should pay for my fair' do
      card2.touch_in
      expect{card2.touch_out(2)}.to change{card2.balance}.by(-2)
    end
    # it 'raise an error if balance is too low' do
    #   expect { card.touch_out(2.40) }.to raise_error('Insuficient funds')
    # end
  end

  # describe '#entry_station' do
  #   it 'registers entry station' do
  #   card3 = double(:oystercard, :entry_station => "Oxford Street")
  #   expect(card3.entry_station).to eq "Oxford Street"
  #   end
  # end

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

end
