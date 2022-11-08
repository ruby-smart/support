# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Float extensions' do
  before do
    @nb = 45.5678
  end

  describe "#round_down" do
    it "should round down to 0 decimals" do
      expect(@nb.round_down).to eq 45
    end

    it "should round down to 2 decimals" do
      expect(@nb.round_down(2)).to eq 45.56
    end
  end

  describe "#round_up" do
    it "should round up to 0 decimals" do
      expect(@nb.round_up).to eq 46
    end

    it "should round up to 2 decimals" do
      expect(@nb.round_up(2)).to eq 45.57
    end
  end
end