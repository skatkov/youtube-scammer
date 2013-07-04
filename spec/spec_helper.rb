require 'rspec'
Dir['../lib/*.rb'].each{|file| require file}
Dir['../model/*.rb'].each{|file| require file}
require_relative '../scammer.rb'
require_relative '../scammer_engine.rb'