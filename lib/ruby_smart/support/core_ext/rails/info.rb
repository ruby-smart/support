# frozen_string_literal: true

require 'rails/info'

# add additional property for info
# The current thread information
Rails::Info.property 'Thread' do
  ::RubySmart::Support::ThreadInfo.info
end

# The current Bundler version
Rails::Info.property 'Bundler' do
  ::Bundler::VERSION if defined?(::Bundler::VERSION)
end