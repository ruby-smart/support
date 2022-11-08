# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Hash extensions', skip: spec_skip_activesupport? do
  before do
    @hash = { a: 1, b: 2, c: 3 }
  end

  describe "#only!" do
    it "should be replaced by an empty hash" do
      expect(@hash.only!).to eq({})
      expect(@hash).to eq({})
    end

    it "should be replaced by requested keys" do
      expect(@hash.only!(:a)).to eq({ a: 1 })
      expect(@hash).to eq({ a: 1 })
    end
  end

  describe "#without!" do
    it "should eq by provided empty string" do
      expect(@hash.without!).to eq({})
      expect(@hash).to eq({ a: 1, b: 2, c: 3 })
    end

    it "should be reduced by requested keys" do
      expect(@hash.without!(:a)).to eq({ a: 1 })
      expect(@hash).to eq({ b: 2, c: 3 })
    end
  end

  describe "#deep_reject" do
    it "should remove numbers > 2" do
      hsh = {a: 1, b: 2, c: 3, d: {a: 1, b: 2, c: 3}}
      deep_reject_cb = Proc.new {|_k,v| v.is_a?(Numeric) && v > 2 }
      expect(hsh.deep_reject(&deep_reject_cb)).to eq({a: 1, b: 2, d: {a: 1, b: 2}})
      expect(hsh).to eq({a: 1, b: 2, c: 3, d: {a: 1, b: 2, c: 3}})
    end
  end

  describe "#deep_reject!" do
    it "should bew replaced" do
      hsh = {a: 1, b: 2, c: 3, d: {a: 1, b: 2, c: 3}}
      deep_reject_cb = Proc.new {|k,v| k == :d || v == 2 }

      expect(hsh.deep_reject!(&deep_reject_cb)).to eq({a: 1, c: 3})
      expect(hsh).to eq({a: 1, c: 3})
    end
  end
end