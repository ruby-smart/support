# frozen_string_literal: true

unless Hash.method_defined? "to_md5"
  class Hash
    # returns the md5 of any hash by using the +#inspect+ method
    # @return [String] md5
    def to_md5
      Digest::MD5.hexdigest(Hash[self.sort].inspect)
    end
  end
end

# idea by https://stackoverflow.com/questions/9786264/all-possible-combinations-from-a-hash-of-arrays-in-ruby
unless Hash.method_defined? "product"
  class Hash
    # creates a 'product' of all values per existing key as a combination
    #
    #   hash = { first: [:a,:b], second: [:x,:c]}
    #   > [{:first=>:a, :second=>:x}, {:first=>:a, :second=>:c}, {:first=>:b, :second=>:x}, {:first=>:b, :second=>:c}]
    #
    # @return [Array] combinations
    def product
      product = values[0].product(*values[1..-1])
      product.map{|p| Hash[keys.zip p]}
    end
  end
end