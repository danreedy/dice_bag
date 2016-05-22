module DiceBag
  class Dice
    DEFAULT_SIDES = 6
    attr_reader :sides

    def initialize(sides=DEFAULT_SIDES)
      sides = sides.to_i
      raise DiceBag::InvalidSidesError, 'Dice must have a positive integer number of sides' if sides <= 0
      raise DiceBag::TooLargeError, 'Dice has too many sides' if sides > 1000
      @sides = sides
    end

    def roll(seed=nil)
      randomizer(seed).rand(1..@sides)
    end

    def rolls(number_of_times)
      raise DiceBag::InvalidSidesError, 'number of times to roll must be a positive integer' if number_of_times < 0
      number_of_times.times.collect { roll }
    end

    private
    def randomizer(seed)
      @randomizer ||= (seed.nil? ? Random.new : Random.new(seed))
    end
  end
end
