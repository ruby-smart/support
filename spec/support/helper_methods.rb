# frozen_string_literal: true

def spec_skip_rake?
  RubySmart::Support::GemInfo.safe_require('rake') ? false : 'rake is not available'
end

def spec_skip_activesupport?
  RubySmart::Support::GemInfo.loaded?('activesupport') ? false : 'activesupport is not available'
end