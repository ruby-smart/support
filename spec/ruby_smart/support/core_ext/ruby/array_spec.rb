# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Array extensions' do
  before do
    @ary = [:a, :b, :c]
  end

  describe "#only" do
    it "should return an empty array" do
      expect(@ary.only).to eq([])
      expect(@ary).to eq [:a, :b, :c]
    end

    it "should return requested values" do
      expect(@ary.only(:a, :c)).to eq [:a, :c]
      expect(@ary.only(:b, :d)).to eq [:b]
      expect(@ary).to eq [:a, :b, :c]
    end
  end

  describe "#only!" do
    it "should be replaced by an empty array" do
      expect(@ary.only!).to eq([])
      expect(@ary).to eq([])
    end

    it "should be replace by requested values" do
      expect(@ary.only!(:a)).to eq [:a]
      expect(@ary).to eq [:a]
    end
  end
end