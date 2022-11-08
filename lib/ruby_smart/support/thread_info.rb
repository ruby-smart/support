# frozen_string_literal: true

require 'io/console'

module RubySmart
  module Support
    module ThreadInfo

      # defines a array of types which will be checked by resolving the current thread type
      TYPE_ORDER = [:rake, :console, :server].freeze

      # returns true if this is a running rake process
      # @return [Boolean]
      def self.rake?
        !!defined?(Rake.application) && Rake.application.top_level_tasks.any?
      end

      # returns true if this is a running rails process
      # @return [Boolean]
      def self.rails?
        !!defined?(Rails.application)
      end

      # returns true if this is a running console process
      # @return [Boolean]
      def self.console?
        irb? || pry? || io_console?
      end

      # returns true if this is a running IRB process
      # @return [Boolean]
      def self.irb?
        !!defined?(IRB)
      end

      # returns true if this is a running Pry process
      # @return [Boolean]
      def self.pry?
        !!defined?(Pry)
      end

      # returns true if this is a running server process.
      # currently only detects rails
      # @return [Boolean]
      def self.server?
        !!defined?(Rails::Server)
      end

      # returns true if this is a running rails console process
      # @return [Boolean]
      def self.rails_console?
        console? && !!(defined?(Rails::Console) || ENV['RAILS_ENV'])
      end

      # returns true if this is a running IO console process
      # @return [Boolean]
      def self.io_console?
        !!defined?(IO.console) && !!IO.console
      end

      # returns true if this is a running thread process.
      # as it always should ...
      # @return [Boolean]
      def self.thread?
        !!thread
      end

      # returns the current thread
      # @return [Thread]
      def self.thread
        ::Thread.current
      end

      # returns the current thread id
      # @return [Integer] thread_id
      def self.thread_id
        thread? ? thread.object_id : 0
      end

      # returns the ascertained id
      # @return [Integer] id
      def self.process_object_id
        return Rake.application.top_level_tasks.first.object_id if rake?
        return Rails.application.object_id if rails?
        thread_id
      end

      # returns the OS process id
      # @return [Integer] id
      def self.id
        $$
      end

      # returns the current thread name
      # - for rake tasks the task name
      # - for rails the application name
      #
      # @return [String] name
      def self.name
        return Rake.application.top_level_tasks.first.to_s if rake?
        return Rails.application.to_s.split('::').first if rails?
        ''
      end

      # returns the current thread by logical order
      # defined through const TYPE_ORDER
      # @return [nil, Symbol]
      def self.type
        TYPE_ORDER.detect { |type| self.send("#{type}?") } || :unknown
      end

      # returns the thread type string
      # @return [String] thread-info string
      def self.info
        strs = ["$#{id}", "[##{process_object_id}]","@ #{type}"]
        strs << " :: #{name}" if name != ''
        strs.join ' '
      end

      # returns true if thread has a 'window'
      # @return [Boolean]
      def self.windowed?
        winsize[1] > 0
      end

      # returns the current windows size, if current IO has a window
      # @return [Array<rows, columns>] winsize
      def self.winsize
        return IO.console.winsize if io_console?
        return [ENV['ROWS'], ENV['COLUMNS']] unless ENV['ROWS'].nil? && ENV['COLUMNS'].nil?
        [0, 0]
      end

      # return true if a log can be send to stdout
      def self.stdout?
        console? && windowed?
      end
    end
  end
end