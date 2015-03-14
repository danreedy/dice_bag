module DiceBag
  class Bag
    attr_reader :notation
    def initialize(dice_type)
      @drop_low = false
      @drop_high = false
      @notation = dice_type
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
        dice.roll(dice_seed)
      end
      if @drop_low
        results.delete_at(results.find_index(results.min))
      elsif @drop_high
        results.delete_at(results.find_index(results.max))
      end
      results
    end

    def describe
      desc_array = ["holds #{@quantity.to_words} #{@sides.to_words}-sided #{'die'.pluralize(@quantity)}"]
      desc_array << "with the lowest result dropped" if @drop_low
      desc_array << "with the highest result dropped" if @drop_high
      desc_array.join(' ')
    end

    private
    def parse(dice_type)
      recipe = /(?<quantity>\d*)d(?<sides>\d+)-*(?<drop>[LH])*/.match(dice_type)
      raise ArgumentError, 'Invalid dice notation' if recipe.nil?
      @quantity = recipe[:quantity].empty? ? 1 : recipe[:quantity].to_i
      @sides = recipe[:sides].to_i
      @drop_low = recipe[:drop].eql?("L")
      @drop_high = recipe[:drop].eql?("H")
      # @quantity.times do
      #   add_dice DiceBag::Dice.new(recipe[:sides])
      # end
      fill_bag(@quantity, @sides)
    end

    def fill_bag(quantity, sides)
      quantity.times do
        add_dice DiceBag::Dice.new(sides)
      end
    end
  end
end
