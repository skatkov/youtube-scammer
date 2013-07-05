require 'rspec'
require 'webmock'
require 'vcr'
Dir['../lib/*.rb'].each{|file| require file}
Dir['../model/*.rb'].each{|file| require file}
require_relative '../scammer.rb'
require_relative '../scammer_engine.rb'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday
  c.debug_logger = File.open("log.txt", 'w')
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end