# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubySmart::Support::GemInfo do
  describe ".installed" do
    it 'returns a hash of all installed gems' do
      expect(RubySmart::Support::GemInfo.installed).to be_a Hash
    end

    it 'has gem name as keys' do
      expect(RubySmart::Support::GemInfo.installed.keys).to include 'rspec-core'
    end

    it 'has gem versions as values' do
      expect(RubySmart::Support::GemInfo.installed['rspec-core']).to include ::RSpec::Core::Version::STRING
    end
  end

  describe ".installed?" do
    it 'returns true for a installed gem' do
      expect(RubySmart::Support::GemInfo.installed?('rspec-core')).to be true
    end

    it 'with any valid version string' do
      expect(RubySmart::Support::GemInfo.installed?('rspec-core', '> 1.0.0')).to be true
    end

    it 'returns false for unknown gem' do
      expect(RubySmart::Support::GemInfo.installed?('unknown and invalid gem')).to be false
    end
  end

  describe ".loaded" do
    it 'returns a hash of loaded gem names' do
      expect(RubySmart::Support::GemInfo.loaded).to be_a Hash
    end
  end

  describe ".loaded?" do
    it 'returns true for a loaded gem' do
      expect(RubySmart::Support::GemInfo.loaded?('rspec')).to be true
    end

    it 'with version requirement' do
      expect(RubySmart::Support::GemInfo.loaded?('rspec', '> 3.0.0')).to be true
    end

    it 'with wrong version requirement' do
      expect(RubySmart::Support::GemInfo.loaded?('rspec', '> 999.0.0')).to be false
    end

    it 'returns false for unknown gem' do
      expect(RubySmart::Support::GemInfo.loaded?('unknown and invalid gem')).to be false
    end
  end

  describe ".required" do
    it 'returns an array of active gem names' do
      expect(RubySmart::Support::GemInfo.required).to be_a Array
      expect(RubySmart::Support::GemInfo.required).to include 'rspec-core'
      expect(RubySmart::Support::GemInfo.required).to include 'rake'
    end
  end

  describe ".required?" do
    it 'returns true for a required gem' do
      expect(RubySmart::Support::GemInfo.required?('rspec-core')).to be true
    end

    it 'with version requirement' do
      expect(RubySmart::Support::GemInfo.required?('rake', '> 1.0.0')).to be true
    end

    it 'with wrong version requirement' do
      expect(RubySmart::Support::GemInfo.required?('rake', '> 999.0.0')).to be false
    end

    it 'returns false for unknown gem' do
      expect(RubySmart::Support::GemInfo.required?('unknown and invalid gem')).to be false
    end
  end

  describe ".features" do
    it 'returns an array of feature names' do
      expect(RubySmart::Support::GemInfo.features).to be_a Array
      expect(RubySmart::Support::GemInfo.features).to include 'rake'
    end

    # it 'extends required feature' do
    #   expect(RubySmart::Support::GemInfo.features).to_not include 'rspec'
    #   require 'rspec'
    #   expect(RubySmart::Support::GemInfo.features).to include 'rspec'
    # end
  end

  describe ".feature?" do
    it 'returns true for a active feature' do
      expect(RubySmart::Support::GemInfo.feature?('rake')).to be true
    end
  end

  describe ".version" do
    it 'returns nil for a unknown gem' do
      expect(RubySmart::Support::GemInfo.version('totally unknown gem')).to be_nil
    end

    it 'returns version string for loaded gem' do
      expect(RubySmart::Support::GemInfo.version('bundler')).to be
      expect(RubySmart::Support::GemInfo.version('rake')).to_not eq '0.0.0'
    end
  end

  describe ".safe_require" do
    it 'returns false for a unknown resource' do
      expect(RubySmart::Support::GemInfo.safe_require('unknown feature')).to be false
    end

    it 'returns true for a feature / gem combination' do
      expect(RubySmart::Support::GemInfo.safe_require('rake/version','rake', '> 0.1.0')).to be true
    end
  end

  describe ".match?" do
    it 'compares versions' do
      expect(RubySmart::Support::GemInfo.match?('4.3.0', '4.3.0')).to be true
      expect(RubySmart::Support::GemInfo.match?('4.3.0', '>= 3.0')).to be true
      expect(RubySmart::Support::GemInfo.match?( '3.3.0', '~> 3.1')).to be true
      expect(RubySmart::Support::GemInfo.match?( '3.3.0', '~>', ' 3.1')).to be true
      expect(RubySmart::Support::GemInfo.match?('0.1.0',  '~> 1.1.0')).to be false
    end

    it 'compares PRE versions' do
      expect(RubySmart::Support::GemInfo.match?('4.3.0.pre', '> 4.3.0')).to be false
      expect(RubySmart::Support::GemInfo.match?( '4.3.0.pre', '>= 4.3.0.pre-1')).to be true
      expect(RubySmart::Support::GemInfo.match?('4.4.0', '>= 4.3.0.pre')).to be true
    end
  end
end