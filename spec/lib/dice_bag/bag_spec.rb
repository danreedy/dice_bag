require 'dice_bag'

RSpec.describe DiceBag::Bag, 'containing a single, six-sided dice' do
  subject { DiceBag::Bag.new("d6") }
  it 'returns a valid count of dice' do
    expect(subject.dice.count).to be 1
  end
  it 'returns a dice with the correct number of sides' do
    expect(subject.dice.first.sides).to be 6
  end
  context '#dump' do
    it 'simulated dumping the dice' do
      results = subject.dump
      expect(results).to be_an Array
    end
  end
end

RSpec.describe DiceBag::Bag, 'Invalid notation' do
  it 'raises an ArgumentError' do
    expect { DiceBag::Bag.new("bad notation") }.to raise_error(ArgumentError, 'Invalid dice notation')
  end
end
