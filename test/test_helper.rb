$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../lib')))

require 'bundler/setup'
Bundler.require(:default, :test)
require 'honclient'
