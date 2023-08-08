# frozen_string_literal: true

unless Enumerator.method_defined? :from_hash
  class Enumerator
    # returns a new array with only values from provided key.
    # The Enumerator must be an array of hashes.
    #
    # @example
    #   ary = [{a: 34, b: 12}, {a: 19, c: 4}, {b: 3, c: 11}]
    #   ary.with_hash(:a)
    #   > [34, 19, nil]
    #
    # @param [Object] key
    # @return [Array] ary
    def from_hash(key)
      map &->(item){item[key]}
    end
  end
end