# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Enumerator extensions' do
  before do
    @ary = [{a: 34, b: 12}, {a: 19, c: 4}, {b: 3, c: 11}]
  end

  describe "#from_hash" do
    it "should return an array" do
      expect(@ary.map.from_hash(:a)).to eq([34,19,nil])
    end
  end
end