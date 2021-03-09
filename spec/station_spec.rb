require 'station'

describe Station do
  subject { Station.new('Finsbury', 2) }
  describe 'can check name and zone after create a station' do
    it 'returns Finsbury when call name' do
      expect(subject.name).to eq 'Finsbury'
    end
    it 'returns 2 when call zone' do
      expect(subject.zone).to eq 2
    end
  end
end