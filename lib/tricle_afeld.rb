require 'rubygems'
require 'bundler/setup'
Bundler.setup

require 'tricle'

dir = File.dirname(__FILE__)
Dir[File.join(dir, 'initializers', '**', '*.rb')].each{|file| require file }
Dir[File.join(dir, 'metrics', '*.rb')].each{|file| require file }
Dir[File.join(dir, '**', '*.rb')].each{|file| require file }
