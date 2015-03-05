require 'dice_bag'

RSpec.describe DiceBag::Counter, 'for single values' do
  subject { DiceBag::Counter.new([6]) }
  context '#to_s' do
    it 'returns a string with the value' do
      expect(subject.to_s).to eq "6"
    end  
  end
  context '#verbose' do
    it 'returns a string with the value' do
      expect(subject.verbose).to eq "6"
    end
  end
end

RSpec.describe DiceBag::Counter, 'for multiple values' do
  subject { DiceBag::Counter.new([3,5,2]) }
  context '#to_s' do
    it 'returns a single number result' do
      expect(subject.to_s).to eq "10"
    end
  end
  context '#verbose' do
    it 'returns the calculation and result' do
      expect(subject.verbose).to eq "10 (3+5+2)"
    end
  end
end

RSpec.describe DiceBag::Counter, 'with modifier' do
  subject { DiceBag::Counter.new([5,7], modifier: 5) }
  context '#to_s' do
    it 'returns a single number result' do
      expect(subject.to_s).to eq "17"
    end
    it 'returns the calculation and result' do
      expect(subject.verbose).to eq "17 (5+7+5)"
    end
  end
end
