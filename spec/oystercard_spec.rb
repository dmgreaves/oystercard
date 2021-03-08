require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new(0) }
  it { is_expected.to respond_to :balance }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe 'top_up' do

    it 'tops up the card balance with the amount ' do
      expect(card.top_up(10)).to eq 10
      expect(card.balance).to eq 10
    end
  end

  describe 'limit' do

  it { is_expected.to respond_to :limit }
  it 'raises an error if topping up over 90' do
    expect { card.top_up(90) }.to raise_error('Reached top up limit of 90')
  end

  it 'raises an error if the balance exceeds 90' do
    card_with_balance = Oystercard.new(50)
    expect {card_with_balance.top_up(50) }.to raise_error('Reached top up limit of 90')
    end
  end
end
