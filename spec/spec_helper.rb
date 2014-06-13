ENV['RUBY_ENV'] ||= 'test'
require 'minitest/autorun'

require_relative '../models'
Dir['../ext/*.rb'].each { |file| require file }
Dir['../model/*.rb'].each { |file| require file }
require_relative '../scammer'
require_relative '../scammer_engine'

#Test should be quiet
def pp(*args); end

class SequelTestCase < MiniTest::Test
  def run(*args, &block)
    Sequel::Model.db.transaction(:rollback=>:always){super}
    self
  end
end