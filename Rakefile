# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require 'yard'
YARD::Rake::YardocTask.new(:doc) do |t|
  t.options = %w| --embed-mixins --markup=markdown|
  t.files = ['lib/**/*.rb','-','docs/*.*']
end

desc 'Release new version'
task :release do
  version = RubySmart::Support::VERSION
  puts "Releasing #{version}, y/n?"
  exit(1) unless $stdin.gets.chomp == 'y'
  sh "git commit -am 'tagged #{version}' && " \
     "git tag #{version} && " \
     "gem build -o pkg/release-#{version}.gem && " \
     "gem push pkg/release-#{version}.gem && " \
     'git push && ' \
     'git push --tags'
end

task default: :spec