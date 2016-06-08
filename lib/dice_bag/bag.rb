module DiceBag
  class Bag
    attr_reader :notation, :modifier, :roll_record
    def initialize(dice_type, max_rolls=100)
      @drop_low = false
      @drop_high = false
      @notation = dice_type
      @max_rolls = max_rolls
      @modifier = 0
      @roll_record = []
      parse dice_type
    end

    def add_dice(new_dice)
      dice << new_dice
    end

    def dice
      @dice ||= []
    end

    def dump(seed=nil)
      results = @dice.collect.with_index do |dice, index|
        dice_seed = seed.nil? ? nil : seed.to_i + index
        roll = dice.roll(dice_seed)
        roll_record << roll
        roll
      end
      if @drop_low
        results.delete_at(results.find_index(results.min))
      elsif @drop_high
        results.delete_at(results.find_index(results.max))
      end
      results
    end

    def roll_times(x, seed: nil)
      seed ||= rand(1_000_000_000)
      result = x.times.collect do
        counter = DiceBag::Counter.new(self.dump(seed), modifier: @modifier)
        counter.total
      end
      result.inject(&:+)
    end

    def roll_once(seed: nil)
      roll_times(1, seed: seed)
    end

    def describe
      desc_array = ["holds #{@quantity.to_words} #{@sides.to_words}-sided #{'die'.pluralize(@quantity)}"]
      desc_array << "with the lowest result dropped" if @drop_low
      desc_array << "with the highest result dropped" if @drop_high
      desc_array << "with a modifier of #{@modifier}" unless @modifier == 0
      desc_array.join(' ')
    end

    private
    def parse(dice_type)
      recipe = /(?<quantity>\d*)d(?<sides>\d+)-*((?<drop>[LH])|(?<neg>\d+))*\+*(?<pos>\d+)*/.match(dice_type)
      raise DiceBag::InvalidNotationError, 'Invalid dice notation' if recipe.nil?
      @quantity = recipe[:quantity].empty? ? 1 : recipe[:quantity].to_i
      raise DiceBag::TooManyRollsError, 'Too many rolls' if @quantity > @max_rolls
      @sides = recipe[:sides].to_i
      @drop_low = recipe[:drop].eql?("L")
      @drop_high = recipe[:drop].eql?("H")
      @modifier -= recipe[:neg].to_i unless recipe[:neg].nil?
      @modifier += recipe[:pos].to_i unless recipe[:pos].nil?
      fill_bag(@quantity, @sides)
    end

    def fill_bag(quantity, sides)
      quantity.times do
        add_dice DiceBag::Dice.new(sides)
      end
    end
  end
end
