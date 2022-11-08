# frozen_string_literal: true

module RubySmart
  module Support
    module GemInfo

      # regexp to detect a gems path
      GEM_PATH_REGEXP = /\/gems\//

      # regexp to resolves a name from a gem path
      GEM_NAME_REGEXP = /\/gems\/([A-za-z0-9_\-]+)\-[\d\w\-\_\.]+\//

      # regexp to resolves a feature from a gem path
      FEATURE_NAME_REGEXP = /\/gems\/([A-za-z0-9_\-]+)\-[\d\w\-\_\.]+\/lib\/(?:\1\/(\1)|([A-za-z0-9_\-]+))\.rb/

      # returns a hash of all installed gems with it's versions
      #
      #   GemInfo.installed
      #   > {'bundler' => ['2.2.30', '1.2.3']}
      #
      # @return [Hash{<name> => Array[<version>]}] gem name-versions hash
      def self.installed
        Hash[::Gem::Specification.reduce({}) { |m, g| m[g.name] ||= []; m[g.name] << g.version.to_s; m }.sort]
      end

      # returns true if the provided gem name is installed.
      # the optional version requirement matches against any available version
      #
      #   GemInfo.installed?('bundler')
      #   > true
      #
      #   GemInfo.installed?('bundler', '~> 3.0')
      #   > false
      #
      # @param [String] name - the gem name
      # @param [nil, String] version - optional version requirement
      # @return [Boolean]
      def self.installed?(name, version = nil)
        installed.key?(name) && (version.nil? || installed[name].any? { |gem_version| match?(version, gem_version) })
      end

      # returns a hash of all loaded gems with its current version
      #
      #   GemInfo.loaded
      #   > {'bundler' => '2.2.30'}
      #
      # @return [Hash{<name> => <version>}] gem name-version hash
      def self.loaded
        Hash[::Gem.loaded_specs.values.map { |g| [g.name, g.version.to_s] }.sort]
      end

      # returns true if the provided gem name is loaded.
      # the optional version requirement matches against the loaded version
      #
      #   GemInfo.loaded?('bundler')
      #   > true
      #
      #   GemInfo.loaded?('bundler', '~> 3.0')
      #   > false
      #
      # @param [String] name - the gem name
      # @param [nil, String] version - optional version requirement
      # @return [Boolean]
      def self.loaded?(name, version = nil)
        loaded.key?(name) && (version.nil? || match?(version, loaded[name]))
      end

      # returns an array of all active gems
      #
      #   GemInfo.active
      #   > ['bundler']
      #
      # @return [Array<name>}] gem names
      def self.active
        $LOADED_FEATURES.
          select { |feature| feature.match(GEM_PATH_REGEXP) }.
          map { |feature|
            m = feature.match(GEM_NAME_REGEXP)
            m ? m[1] : File.dirname(feature).split('/').last
          }.
          uniq.
          sort
      end

      # returns true if the provided gem name is active.
      # the optional version requirement matches against the *loaded* version
      #
      #   GemInfo.active?('bundler')
      #   > true
      #
      #   GemInfo.active?('bundler', '~> 3.0')
      #   > false
      #
      # @param [String] name - the gem name
      # @param [nil, String] version - optional version requirement
      # @return [Boolean] activated?
      def self.active?(name, version = nil)
        active.include?(name) && (version.nil? || match?(version, version(name)))
      end

      # returns an array of all loaded features
      #
      #   GemInfo.features
      #   > ['active_support','bundler']
      #
      # @return [Array<String>}] module names
      def self.features
        $LOADED_FEATURES.
          select { |feature| feature.match(GEM_PATH_REGEXP) }.
          map { |feature|
            m = feature.match(FEATURE_NAME_REGEXP)
            m ? (m[2] || m[3]) : nil
          }.
          uniq.
          compact.
          sort
      end

      # returns true if the provided feature is loaded.
      #
      #   GemInfo.feature?('active_support')
      #   > true
      #
      # @param [String] name - the feature name
      # @return [Boolean]
      def self.feature?(name)
        features.include?(name)
      end

      # returns the currently loaded gem version
      #
      #   GemInfo.version 'bundler'
      #   > '2.2.30'
      #
      # @return [String,nil] current gem version - return nil if the gem wasn't found
      def self.version(name)
        loaded[name]
      end

      # safe requires a feature by provided name & optional gem
      #
      #   GemInfo.safe_require('rake')
      #   > true
      #
      #   GemInfo.safe_require('active_support')
      #   > true
      #
      #   GemInfo.safe_require('action_view/helpers/date_helper','actionview', '> 0.1.0')
      #   > true
      #
      # @param [String] path - the resource path
      # @param [nil,String] gem - optional gem name
      # @param [nil,String] version - optional gem version compare string
      # @return [Boolean]
      def self.safe_require(path, gem = nil, version = nil)
        # check for missing gem (nicely check if the feature name differs to the gem name)
        return false if !gem.nil? && path != gem && !active?(gem, version)

        # try to require the feature
        begin
          require path
        rescue LoadError, NameError
          return false
        end

        # just the final true result
        true
      end

      # compares two versions against each other
      #
      #   match?('4.3.0', '4.3.0')
      #   > true
      #
      #   match?('>= 3.0', '4.3.0')
      #   > true
      #
      #   match?( '~> 3.1', '3.3.0')
      #   > true
      #
      #   match?( '~> 1.1.0', '0.1.0')
      #   > false
      def self.match?(version_requirement, version_current)
        return true if version_requirement.nil?

        # split version compare operators
        version_requirement_str = version_requirement.gsub(/([=~>< ]+)/, '')
        version_requirement_op  = $1

        # create plain versions without compare operators
        gem_version_current     = Gem::Version.new(version_current)
        gem_version_requirement = Gem::Version.new(version_requirement_str)

        # check if required version is PRE & current is NOT
        if gem_version_requirement.prerelease? && !gem_version_current.prerelease?
          version_requirement = "#{version_requirement_op}#{gem_version_requirement.release}"
        elsif gem_version_requirement.prerelease? != gem_version_current.prerelease?
          # check if required version PRE doesn't equal current version PRE
          version_current = gem_version_current.release.to_s
        end
        # else is not required here: either its PRE && PRE || !PRE && !PRE

        Gem::Dependency.new('', version_requirement).match?('', version_current)
      end
    end
  end
end