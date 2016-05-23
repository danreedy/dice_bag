require 'dice_bag'

RSpec.describe DiceBag::QRandom do
  subject { DiceBag::QRandom.new }
  it 'is a QRandom object' do
    expect(subject).to be_a DiceBag::QRandom
  end

  describe '#route' do
    it 'requests 1 uint8 by default' do
      expect(subject.route).to eq "https://qrng.anu.edu.au/API/jsonI.php?length=1&type=uint8"
    end
  end

  describe '#response' do
    it 'returns a JSON result' do
      VCR.use_cassette('random_uint8') do
        subject.fetch
        expect(subject.response).to eq '{"type":"uint8","length":1,"data":[44],"success":true}'
      end
    end
  end

  describe '#results' do
    it 'returns a random number' do
      VCR.use_cassette('random_uint8') do
        subject.fetch
        expect(subject.results).to eq 44
      end
    end
  end

  describe '#upto' do
    it 'returns a random number' do
      VCR.use_cassette('too_large_uint8') do
        subject.fetch.upto(100)
        expect(subject.results).to eq 76
      end
    end
  end

  describe '#rand' do
    it 'returns a random number in the range' do
      VCR.use_cassette('too_large_uint8') do
        expect(subject.rand(1..100)).to eq 76
      end
    end
  end

end
