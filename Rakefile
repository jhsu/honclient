require 'bundler/setup'
Bundler.require(:default, :test)
require 'rspec/core/rake_task'

desc "run tests"
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = '--color --format nested'
	t.pattern = './test/*_spec.rb'
end

task :default => :spec
