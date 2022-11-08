# frozen_string_literal: true

module RubySmart
  module Support
    # Returns the version of the currently loaded module as a <tt>Gem::Version</tt>
    def self.gem_version
      Gem::Version.new VERSION::STRING
    end

    module VERSION
      MAJOR = 0
      MINOR = 1
      TINY  = 0
      PRE   = nil

      STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".")

      def self.to_s
        STRING
      end
    end
  end
end