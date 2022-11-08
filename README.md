# RubySmart::Support

[![Gem Version](https://badge.fury.io/rb/ruby_smart-support.svg)](https://badge.fury.io/rb/ruby_smart-support)

A toolkit of support libraries including GemInfo, ThreadInfo, Ruby core extensions & activesupport extensions

-----

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_smart-support'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby_smart-support

## Features
* validate & check gems through GemInfo
* resolve information about the current ruby's thread through ThreadInfo

## Module ThreadInfo

The `ThreadInfo` module provides information about the current thread.

### Usage Examples

```ruby
require 'thread_info'

# returns true, if this is a console
ThreadInfo.console?
# > true

# returns the current thread name (rake / rails)
ThreadInfo.name
# > true

# returns true if thread has a 'window'
ThreadInfo.window?
# > true

# returns the thread type string
ThreadInfo.info
# > "$534435 [#235] @ console :: RakeTaskName"
```

### Available methods
* rake?
* rails?
* console?
* irb?
* pry?
* server?
* rails_console?
* io_console?
* thread?
* thread
* thread_id
* process_object_id
* id
* name
* type
* info
* windowed?
* winsize
* stdout?

## Module GemInfo

The `GemInfo` module provides information about the installed and loaded gems & features.

### Usage Examples

```ruby
require 'gem_info'

# returns a hash of all installed gems with it's versions
# (gems within the currently installed ruby version)
GemInfo.installed
# > {'bundler' => ['2.2.30', '1.2.3'], ...}

# returns a hash of all loaded gems with its current version
# (gems from the Gemfile)
GemInfo.loaded
# > {'bundler' => '2.2.30', ...}

# returns an array of all active gems
GemInfo.active
# > ['bundler', ...]

# returns an array of all loaded features
GemInfo.features
# > ['active_support','bundler']

# safe requires a feature by provided name & optional gem
GemInfo.safe_require('activesupport')
# > false
GemInfo.safe_require('active_support')
# > true
GemInfo.safe_require('action_view/helpers/date_helper','actionview', '> 0.1.0')
# > true

# compares two versions against each other
GemInfo.match?('4.3.0', '4.3.0')
# > true
#
GemInfo.match?('>= 3.0', '4.3.0')
# > true
#
GemInfo.match?( '~> 3.1', '3.3.0')
# > true
#
GemInfo.match?( '~> 1.1.0', '0.1.0')
# > false
```

### Available methods
* installed
* installed?
* loaded
* loaded?
* active
* active?
* features
* feature?
* version
* safe_require
* match?

-----

## Docs

[CHANGELOG](./docs/CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at [elasticsearch_record](https://github.com/ruby-smart/support).
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](./docs/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

A copy of the [LICENSE](./docs/LICENSE.txt) can be found @ the docs.

## Code of Conduct

Everyone interacting in the project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [CODE OF CONDUCT](./docs/CODE_OF_CONDUCT.md).
