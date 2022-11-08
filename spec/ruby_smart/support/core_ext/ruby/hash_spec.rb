# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Hash extensions' do
  before do
    @hash = { a: 1, b: 2, c: 3 }
  end

  describe "#to_md5" do
    it "should return the md5 hash" do
      expect(@hash.to_md5).to eq '36fc2c864382f831495f01d845241b20'
    end

    it "should be equal with a different order" do
      hash2 = { b: 2, c: 3, a: 1 }
      expect(@hash.to_md5).to eq hash2.to_md5
    end
  end

  describe "#product" do
    it "should return the product of all hash values" do
      @hash2 = { first: [:a,:b, :c], second: [:a,:c]}
      expect(@hash2.product).to eq [{:first=>:a, :second=>:a}, {:first=>:a, :second=>:c}, {:first=>:b, :second=>:a}, {:first=>:b, :second=>:c}, {:first=>:c, :second=>:a}, {:first=>:c, :second=>:c}]
    end
  end
end