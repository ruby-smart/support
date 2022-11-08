# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'String extensions' do
  describe "#to_boolean" do
    it "should be false" do
      expect("This is a very nice string".to_boolean).to eq false
      expect("01".to_boolean).to eq false
      expect("truly".to_boolean).to eq false
    end

    it "should be true" do
      expect("1".to_boolean).to eq true
      expect("TrUe".to_boolean).to eq true
      expect("TRUE".to_boolean).to eq true
      expect("true".to_boolean).to eq true
    end
  end

  describe "#to_md5" do
    it "should return the md5 hash" do
      expect("This is a very nice string".to_md5).to eq 'e7b0e10882fc9c875bd08e4e0ea1c5f8'
    end
  end
end