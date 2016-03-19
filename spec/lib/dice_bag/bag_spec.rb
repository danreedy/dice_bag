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
  describe '#describe' do
    subject { DiceBag::Bag.new(dice) }
    context 'a single d20' do
      let(:dice) { "d20" }
      it 'holds one twenty-sided die' do
        expect(subject.describe).to eq "holds one twenty-sided die"
      end
    end
    context '4d6' do
      let(:dice) { "4d6" }
      it 'holds four six-sided dice' do
        expect(subject.describe).to eq "holds four six-sided dice"
      end
    end
    context '4d6-L' do
      let(:dice) { "4d6-L" }
      it 'holds four six-sided dice with the lowest result dropped' do
        expect(subject.describe).to eq "holds four six-sided dice with the lowest result dropped"
      end
    end
    context '4d6-H' do
      let(:dice) { "4d6-H" }
      it 'holds four six-sided dice with the highest result dropped' do
        expect(subject.describe).to eq "holds four six-sided dice with the highest result dropped"
      end
    end
  end
end

RSpec.describe DiceBag::Bag, 'Invalid notation' do
  it 'raises an InvalidNotationError' do
    expect { DiceBag::Bag.new("bad notation") }.to raise_error(DiceBag::InvalidNotationError, 'Invalid dice notation')
  end
end

RSpec.describe DiceBag::Bag, 'Too many rolls' do
  it 'raises a TooManyRollsError' do
    expect { DiceBag::Bag.new("101d6") }.to raise_error(DiceBag::TooManyRollsError, 'Too many rolls')
  end
end
