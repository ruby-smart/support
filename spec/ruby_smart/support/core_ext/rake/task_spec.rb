# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Rake::Task extensions', skip: spec_skip_rake? do
  describe '#append' do
    it 'appends action' do
      task = ::Rake::Task.define_task(:gtc_dummy_task0) do
        'first action'
      end

      expect(task.actions.count).to eq 1

      task.append do
        'second action'
      end

      expect(task.actions.count).to eq 2
      expect(task.actions[1].()).to eq 'second action'
    end

    it 'appends action to existing task' do
      task = ::Rake::Task.define_task(:gtc_dummy_task1) do
        'first action'
      end

      ::Rake::Task[:gtc_dummy_task1].append do
        'second action'
      end

      expect(task.actions.count).to eq 2
      expect(task.actions[1].()).to eq 'second action'
    end
  end

  describe '#prepend' do
    it 'prepends action' do
      task = ::Rake::Task.define_task(:gtc_dummy_task2) do
        'first action'
      end

      expect(task.actions.count).to eq 1

      task.prepend do
        'second action'
      end

      expect(task.actions.count).to eq 2
      expect(task.actions[0].()).to eq 'second action'
    end

    it 'prepends action to existing task' do
      task = ::Rake::Task.define_task(:gtc_dummy_task3) do
        'first action'
      end

      ::Rake::Task[:gtc_dummy_task3].prepend do
        'second action'
      end

      ::Rake::Task[:gtc_dummy_task3].prepend do
        'third action'
      end

      expect(task.actions.count).to eq 3
      expect(task.actions[0].()).to eq 'third action'
      expect(task.actions[1].()).to eq 'second action'
    end
  end

  describe '#invoked?' do
    it 'is not invoked by default' do
      task = ::Rake::Task.define_task(:gtc_invoked_dummy_task0) do
        'first action'
      end

      expect(task.invoked?).to eq false
    end

    it 'returns invoked state' do
      task = ::Rake::Task.define_task(:gtc_invoked_dummy_task1) do
        'first action'
      end

      task1 = ::Rake::Task.define_task(:gtc_invoked_dummy_task2) do |t|
        Rake::Task[:gtc_invoked_dummy_task1].invoke
      end

      expect(task.invoked?).to eq false
      expect(task1.invoked?).to eq false

      task1.execute

      expect(task.invoked?).to eq true
      expect(task1.invoked?).to eq false
    end
  end

  describe '#performed?' do
    it 'is not performed by default' do
      task = ::Rake::Task.define_task(:gtc_performed_dummy_task0)

      expect(task.performed?).to eq false
    end

    it 'is performed after run' do
      task = ::Rake::Task.define_task(:gtc_performed_dummy_task1)
      task.execute

      expect(task.performed?).to eq true
    end
  end

  describe '#running?' do
    it 'is not running by default' do
      task = ::Rake::Task.define_task(:gtc_running_dummy_task0)

      expect(task.running?).to eq false
    end

    it 'is running during run' do
      scope = self

      task = ::Rake::Task.define_task(:gtc_running_dummy_task1) do |t|
        scope.expect(t.running?).to eq true
      end

      task.execute

      expect(task.running?).to eq false
    end
  end
end