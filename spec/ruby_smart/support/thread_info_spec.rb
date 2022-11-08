# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubySmart::Support::ThreadInfo do

  describe '.thread?' do
    it 'should be always a thread' do
      expect(RubySmart::Support::ThreadInfo.thread?).to be true
    end
  end

  describe '.thread_id' do
    it 'should return a thread id' do
      expect(RubySmart::Support::ThreadInfo.thread_id).to_not eq 0
    end
  end

  describe '.process_object_id' do
    it 'should return a process id' do
      expect(RubySmart::Support::ThreadInfo.process_object_id).to_not eq 0
    end
  end

  describe '.id' do
    it 'should return a running id' do
      expect(RubySmart::Support::ThreadInfo.id).to be
    end
  end

  describe '.info' do
    it 'should return the thread info string' do
      info = RubySmart::Support::ThreadInfo.info

      expect(info).to include RubySmart::Support::ThreadInfo.id.to_s
      expect(info).to include RubySmart::Support::ThreadInfo.process_object_id.to_s
      expect(info).to include RubySmart::Support::ThreadInfo.type.to_s
    end
  end

  describe '.winsize' do
    it 'should return an array' do
      expect(RubySmart::Support::ThreadInfo.winsize).to be_a Array
    end
  end

  # PLEASE NOTE: The following methods are hardly to test due different gem requirements & scenarios
  # so we have to dynamically test

  describe 'dynamic implemented' do
    it '.id' do
      expect(RubySmart::Support::ThreadInfo.id).to eq $$
    end

    it '.windowed??' do
      expect(RubySmart::Support::ThreadInfo.windowed?).to_not be_nil
    end

    it '.server?' do
      expect(RubySmart::Support::ThreadInfo.server?).to_not be_nil
    end

    it '.stdout?' do
      expect(RubySmart::Support::ThreadInfo.stdout?).to_not be_nil
    end

    it '.rails_console?' do
      expect(RubySmart::Support::ThreadInfo.rails_console?).to_not be_nil
    end

    it '.io_console?' do
      expect(RubySmart::Support::ThreadInfo.io_console?).to_not be_nil
    end

    it '.type' do
      expect(RubySmart::Support::ThreadInfo.type).to_not be_nil
    end
  end
end