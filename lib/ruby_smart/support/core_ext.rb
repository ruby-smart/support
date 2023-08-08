# frozen_string_literal: true

require_relative "core_ext/ruby/array"
require_relative "core_ext/ruby/enumerator"
require_relative "core_ext/ruby/float"
require_relative "core_ext/ruby/hash"
require_relative "core_ext/ruby/object"
require_relative "core_ext/ruby/string"

require_relative "gem_info"

# activesupport related stuff
if RubySmart::Support::GemInfo.loaded?('activesupport')
  require_relative "core_ext/activesupport/hash"
end

# load Rails related stuff
if RubySmart::Support::GemInfo.loaded?('rails')
  # since the Rails::Info.property block-returns are stored on call we need to wait
  # until we have information about the rails application.
  # This is done with the following hook
  ActiveSupport.on_load(:before_initialize) do
    require_relative "core_ext/rails/info"
  end
end

# load Rake related stuff
if RubySmart::Support::GemInfo.loaded?('rake')
  require_relative "core_ext/rake/task"
end