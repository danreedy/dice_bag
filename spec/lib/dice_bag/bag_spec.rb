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
  context '#roll_times' do
    subject { DiceBag::Bag.new(dice) }
    context 'with a d20+4' do
      let(:dice) { "d20+4" }
      it 'contains one die' do
        expect(subject.dice.count).to eq 1
      end
      it 'contains a die with twenty sides' do
        expect(subject.dice.first.sides).to eq 20
      end
      it 'has a modifier of positive four' do
        expect(subject.modifier).to eq 4
      end
      it 'returns 24 when a 20 is rolled' do
        allow_any_instance_of(DiceBag::Dice).to receive(:roll).and_return(20)
        expect(subject.roll_once).to eq 24
      end
      it 'returns 5 when a 1 is rolled' do
        allow_any_instance_of(DiceBag::Dice).to receive(:roll).and_return(1)
        expect(subject.roll_once).to eq 5
      end
    end
    context 'with a 2d6+3' do
      let(:dice) { "2d6+3" }
      it 'contains two dice' do
        expect(subject.dice.count).to eq 2
      end
      it 'has dice with 6 sides' do
        expect(subject.dice.collect(&:sides)).to eq [6, 6]
      end
      it 'has a modifier of 3' do
        expect(subject.modifier).to eq 3
      end
      it 'returns 15 when two 6s are rolled' do
        allow_any_instance_of(DiceBag::Dice).to receive(:roll).and_return(6)
        expect(subject.roll_once).to eq 15
      end
    end
    context 'with a d20-1' do
      let(:dice) { "d20-1" }
      it 'has a modifier of -1' do
        expect(subject.modifier).to eq(-1)
      end
      it 'returns 15 when a 16 is rolled' do
        allow_any_instance_of(DiceBag::Dice).to receive(:roll).and_return(16)
        expect(subject.roll_once).to eq 15
      end
    end
    context 'with a d20+11' do
      let(:dice) { "d20+11" }
      it 'has a modifier of 11' do
        expect(subject.modifier).to eq(11)
      end
      it 'returns 20 when a 9 is rolled' do
        allow_any_instance_of(DiceBag::Dice).to receive(:roll).and_return(9)
        expect(subject.roll_once).to eq 20 
      end
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
