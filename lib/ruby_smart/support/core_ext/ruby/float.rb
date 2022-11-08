# frozen_string_literal: true

unless Float.method_defined? :round_down
  class Float
    # returns a new float and rounds down
    #
    # @example
    #   nb = 45.5678
    #   nb.round_down(2)
    #   > 45.56
    #
    # @param [Integer] exp - amount of decimals
    # @return [Float] rounded number
    def round_down(exp = 0)
      multiplier = 10 ** exp
      ((self * multiplier).floor).to_f/multiplier.to_f
    end
  end
end

unless Float.method_defined? :round_up
  class Float
    # returns a new float and rounds up
    #
    # @example
    #   nb = 45.5678
    #   nb.round_up(2)
    #   > 45.57
    #
    # @param [Integer] exp - amount of decimals
    # @return [Float] rounded number
    def round_up(exp = 0)
      multiplier = 10 ** exp
      ((self * multiplier).ceil).to_f/multiplier.to_f
    end
  end
end