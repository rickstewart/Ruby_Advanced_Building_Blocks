#
gem 'rspec'
require 'rspec/core/rake_task'

task :default => :spec

desc "Run tests for Odin Ruby Building Blocks Exercises"
RSpec::Core::RakeTask.new do |task|
  dir = Rake.application.original_dir
  task.pattern = "#{dir}/*_spec.rb"
  task.rspec_opts = [ "-I#{dir}", '-f documentation', '-r ./rspec_config']
  task.verbose = false
end