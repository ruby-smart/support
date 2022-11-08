# frozen_string_literal: true

unless Array.method_defined? :only!
  class Array
    # refactors the same array with only given values (if exists)
    #
    # @example
    #   ary = [:foo, :bar, :bat]
    #   ary.only!(:bar, :moon)
    #   > ary == [:bar]
    #
    # @param [Object] *values
    # @return [Array] self
    def only!(*values)
      reject! {|value| !values.include?(value)}
      self
    end
  end
end

unless Array.method_defined? :only
  class Array
    # returns a new array with only given values (if exists)
    #
    # @example
    #   ary = [:foo, :bar, :bat]
    #   ary.only(:bar, :bat, :moon)
    #   > [:bar, :bat]
    #
    # @param [Object] *values
    # @return [Array] ary
    def only(*values)
      dup.only!(*values)
    end
  end
end