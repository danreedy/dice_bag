require 'net/http'
require 'json'

module DiceBag
  class QRandom
    ANU_ROOT = "https://qrng.anu.edu.au/API/jsonI.php"
    ANU_TYPES = %w| uint8 uint16 hex16 |

    attr_reader :response
    
    def initialize(length=nil,type=nil)
      @length ||= 1  
      @type ||= 'uint8'
      raise DiceBag::InvalidQRandomType unless ANU_TYPES.include?(@type)
    end

    def fetch
      get_random_numbers
      self
    end

    def results
      if @results.count == 1
        @results[0]
      else
        @results
      end
    end

    def upto(max_int)
      @results.each_with_index do |result, i|
        # if result > max_int
          @results[i] = scale_number(result, max_int)
        # end
      end
      self
    end

    def self.rand(constraint)
      new.rand(constraint)
    end

    def rand(constraint)
      if constraint.is_a?(Range)
        fetch.upto(constraint.last).results
      else
        fetch.upto(constraint).results
      end
    end

    def route
      "#{ANU_ROOT}?length=#{@length}&type=#{@type}"
    end

    protected
    def get_random_numbers
      @response = nil
      @results = []
      uri = URI(self.route)
      res = Net::HTTP.get_response(uri)
      if res.code_type == Net::HTTPOK
        @response = res.body.strip
        parse_response(@response)
      else
        raise StandardError, 'unable to fetch random numbers'
      end
    end

    def parse_response(body)
      j = JSON.parse(body.strip)
      @results = j["data"]
    end

    def scale_number(number, max)
      ((number * max) / 255) + 1
    end
  end
end
