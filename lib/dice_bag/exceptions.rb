module DiceBag
  class InvalidSidesError < StandardError; end
  class TooLargeError < StandardError; end
  class InvalidNotationError < StandardError; end
  class TooManyRollsError < StandardError; end
  class QRandomInvertError < StandardError; end
end
