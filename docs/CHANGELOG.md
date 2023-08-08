# RubySmart::Support - CHANGELOG

## [1.3.0] - 2023-08-08
* **[add]** `Enumerator.from_hash` to easily resolve values from Array-of-Hashes (use: ary.map.from_hash(key))
* **[add]** `RubySmart::Support::GemInfo.licenses` to resolve a hash of licences per loaded gem
* **[fix]** `RubySmart::Support::ThreadInfo.winsize`-detection for debug-ENVs
* **[ref]** `RubySmart::Support::ThreadInfo.name` to show full application namespace
* **[ref]** `RubySmart::Support::ThreadInfo.info` to show a optimized info-string

## [1.2.0] - 2023-01-24
* **[ref]** `GemInfo` methods (active -> required & active? -> required?)
* **[ref]** simplify `GemInfo.match?`method
* **[fix]** `Hash#to_md5` method to use `#inspect` instead of `#to_s`

## [1.1.1] - 2022-11-15
* **[fix]** `GemInfo` & `ThreadInfo` not being included on require 'ruby_smart-support'
* **[fix]** yard comments
* **[add]** `yard` gem for documentation

## [1.1.0] - 2022-11-12
* **[ref]** `GemInfo.match?` method to provide method parameters more intuitive like `.match?('3.4.0', '>', '3.1.0')`
* **[fix]** README

## [1.0.0] - 2022-11-08
* **[add]** `GemInfo` module
* **[add]** `ThreadInfo` module
* **[add]** core extensions for ruby
* **[add]** extensions for rails & rake
* **[add]** extensions for optional gem 'activesupport' / hash methods
* **[add]** additional properties to `Rails::Info` - load them after ActiveSupport hooks
* **[add]** rspec & simplecov
* **[add]** Github workflow Test

## [0.1.0] - 2022-11-08
* Initial commit
* docs, version, structure
