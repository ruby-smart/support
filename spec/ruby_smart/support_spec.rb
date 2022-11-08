# frozen_string_literal: true

RSpec.describe RubySmart::Support do
  describe '.version' do
    it "returns a gem version" do
      expect(RubySmart::Support.version).to be_a Gem::Version
    end

    it "has a version number" do
      expect(RubySmart::Support.version.to_s).to eq RubySmart::Support::VERSION::STRING
    end

    it "is a version string" do
      expect(RubySmart::Support::VERSION.to_s).to eq RubySmart::Support::VERSION::STRING
    end
  end
end
