module DiceBag
  class Dice
    DEFAULT_SIDES = 6
    attr_reader :sides

    def initialize(sides=DEFAULT_SIDES)
      sides = sides.to_i
      raise ArgumentError, 'Dice must have a positive integer number of sides' if sides <= 0
      @sides = sides
    end

    def roll
      rand(@sides)+1
    end

    def rolls(number_of_times)
      raise ArgumentError, 'number of times to roll must be a positive integer' if number_of_times < 0
      number_of_times.times.collect { roll }
    end
  end
end
