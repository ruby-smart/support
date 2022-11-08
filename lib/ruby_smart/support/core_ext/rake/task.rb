# frozen_string_literal: true

require 'rake/task'

module Rake
  class Task
    module StatePatch
      # overwriting the execute method to track the current state
      def execute(*args)
        @state = :running
        super
        @state = :done
      end
    end

    prepend StatePatch

    attr_reader :state

    # returns true, if this task was invoked
    # @return [Boolean]
    def invoked?
      !!@already_invoked
    end

    # returns true, if this task performed (executed)
    # @return [Boolean]
    def performed?
      @state == :done
    end

    # returns true, if this task is currently running
    # @return [Boolean]
    def running?
      @state == :running
    end

    # append the given block to the 'actions'-array
    # this method is chainable and returns self
    #
    # @param [Proc] block
    # @return [Rake::Task] self
    def append(&block)
      @actions << block
      self
    end

    # prepends the given block to the 'actions'-array
    # this method is chainable and returns self
    #
    # @param [Proc] block
    # @return [Rake::Task] self
    def prepend(&block)
      @actions.unshift(block)
      self
    end
  end
end
