# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Object extensions' do
  describe "#numeric?" do
    it "should NOT be a numeric class" do
      expect(Dummy::Base.new.numeric?).to be false
      expect("This is not numeric".numeric?).to be false
    end

    it "should be numeric" do
      expect(45.numeric?).to be true
      expect(Dummy::Numeric.new('235').numeric?).to be true
      expect(33.256.numeric?).to be true
      expect('56.674'.numeric?).to be true
    end
  end

  describe "#boolean?" do
    it "should NOT be a boolean class" do
      expect(15.boolean?).to be false
      expect("This is not boolean".boolean?).to be false
      expect(Dummy::Base.new.boolean?).to be false
    end

    it "is boolean" do
      expect(true.boolean?).to be true
      expect(false.boolean?).to be true
    end
  end

  describe ".missing_method?" do
    before do
      @obj = Dummy::Base
      @child = Dummy::Child
    end

    it "should be missing" do
      expect(@obj.missing_method?(:totally_unknown)).to be true
      expect(::Numeric.missing_method?(:totally_unknown)).to be true
      expect(::String.missing_method?(:totally_unknown)).to be true
    end

    it "should be missing without ancestors" do
      expect(@child.missing_method?(:hello, false)).to be true
    end

    it "should exist without ancestors" do
      expect(@child.missing_method?(:world, false)).to be false
    end

    it "should exist" do
      expect(@obj.missing_method?(:hello)).to be false
      expect(@child.missing_method?(:hello)).to be false
      expect(::Numeric.missing_method?(:to_s)).to be false
    end
  end

  describe '.alias_missing_method' do
    before do
      @obj = Dummy::Base
      @child = Dummy::Child
    end

    it "should not replace existing method" do
      expect(@obj.alias_missing_method(:world_alias,:not_world)).to be nil
      expect(@obj.new.world_alias).to eq @obj.new.world

      expect(@child.alias_missing_method(:world_alias,:not_world)).to be nil
      expect(@child.new.world_alias).to eq @child.new.world
    end

    it "should replace missing method" do
      expect(Dummy::AnotherChild.alias_missing_method(:world_alias,:not_world, false)).to_not be nil
      expect(Dummy::AnotherChild.new.world_alias).to eq Dummy::AnotherChild.new.not_world
    end
  end
end