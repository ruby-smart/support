# frozen_string_literal: true

require 'coveralls'
Coveralls.wear! do
  # exclude specs
  add_filter %r{^/spec/}
  # exclude gem related files
  add_filter %w{support.rb}

  add_group "Base" do |file|
    file.filename.match(/\/support\/(?:core_ext|gem_version|version)\.rb/)
  end

  add_group "Rake" do |file|
    file.filename.match(/\/rake\//)
  end

  add_group "Ruby" do |file|
    file.filename.match(/\/ruby\//)
  end

  add_group "Activesupport" do |file|
    file.filename.match(/\/activesupport\//)
  end

  add_group "Modules" do |file|
    file.filename.match(/\/(?:gem_info|thread_info)\.rb/)
  end

  self.formatter = SimpleCov::Formatter::HTMLFormatter unless ENV.fetch('CI', nil)
end