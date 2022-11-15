# frozen_string_literal: true

require 'active_support/core_ext/hash'
require 'active_support/core_ext/object/deep_dup'

unless Hash.method_defined? "only!"
  class Hash
    # Replaces the hash with only the given keys (if exists),
    # but returns the same hash (not the removed keys - this differs to *Hash#slice!*)
    #
    # @example
    #   hsh = {a: 1, b: 2, c: 3}
    #   hsh.only!(:a, :d)
    #   > {a: 1}
    #   > hsh == {a: 1}
    #
    # @param [Array] keys
    # @return [Hash] self
    def only!(*keys)
      slice!(*keys)
      self
    end
  end
end

unless Hash.method_defined? "without!"
  class Hash
    # removes the given keys from hash and returns those key => value pairs
    # (this differs to *Hash#except!*)
    #
    # @example
    #   hsh = {a: 1, b: 2, c: 3}
    #   hsh.without!(:a, :d)
    #   > {a: 1}
    #   > hsh == {b: 2, c: 3}
    #
    # @param [Array] keys
    # @return [Hash] self
    def without!(*keys)
      Hash[to_a - except!(*keys).to_a]
    end
  end
end

unless Hash.method_defined? "deep_reject"
  class Hash
    # returns a new Hash with items that the block evaluates to true removed, also to deep Hashes.
    def deep_reject(&blk)
      deep_dup.deep_reject!(&blk)
    end

    # deep reject by provided block
    # deep remove keys that the block evaluates to true
    #
    # @example
    #   hsh = {a: 1, b: 2, c: 3, d: {a: 1, b: 2, c: 3}}
    #   hsh.deep_reject! {|_k,v| v.is_a?(Numeric) && v > 2}
    #   > hsh == {a: 1, b: 2, d: {a: 1, b: 2}}
    #
    #   hsh = {a: 1, b: 2, c: 3, d: {a: 1, b: 2, c: 3}}
    #   hsh.deep_reject! {|k,v| k == :d || v == 2}
    #   > hsh == {a: 1, c: 3}
    def deep_reject!(&blk)
      each do |k, v|
        if blk.(k, v)
          delete(k)
        elsif v.is_a?(Hash)
          v.deep_reject!(&blk)
        end
      end
    end
  end
end
