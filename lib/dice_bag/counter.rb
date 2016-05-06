module DiceBag
  class Counter
    def initialize(values, modifier: nil)
      @values = values
      @values << modifier.to_i unless modifier.nil?
    end

    def to_s
      total.to_s
    end

    def total
      @values.inject(&:+)
    end

    def verbose
      verbose_pieces = [to_s]
      verbose_pieces << "(#{@values.join('+')})" if @values.count > 1
      verbose_pieces.join(' ')
    end
  end
end
