module DiceBag
  class Bag
    def initialize(dice_type)
      @drop_low = false
      @drop_high = false
      parse dice_type
    end

    def add_dice(new_dice)
      dice << new_dice
    end

    def dice
      @dice ||= []
    end

    def dump
      results = @dice.collect(&:roll)
      if @drop_low
        results.delete_at(results.find_index(results.min))
      elsif @drop_high
        results.delete_at(results.find_index(results.max))
      end
      results
    end

    private
    def parse(dice_type)
      recipe = /(?<quantity>\d*)d(?<sides>\d+)-*(?<drop>[LH])*/.match(dice_type)
      raise ArgumentError, 'Invalid dice notation' if recipe.nil?
      quantity = recipe[:quantity].empty? ? 1 : recipe[:quantity].to_i
      @drop_low = recipe[:drop].eql?("L")
      @drop_high = recipe[:drop].eql?("H")
      quantity.times do
        add_dice DiceBag::Dice.new(recipe[:sides])
      end
    end
  end
end
