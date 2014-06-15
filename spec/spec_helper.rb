ENV['RUBY_ENV'] ||= 'test'
require 'minitest/autorun'
require 'database_cleaner'

require_relative '../models'
Dir['../ext/*.rb'].each { |file| require file }
Dir['../model/*.rb'].each { |file| require file }
require_relative '../scammer'
require_relative '../scammer_engine'

#Test should be quiet
def pp(*args); end

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

class SequelTestCase < MiniTest::Test
  alias_method :_original_run, :run

  def run(*args, &block)
    result = nil
    Sequel::Model.db.transaction(:rollback => :always, :auto_savepoint=>true) do
      result = _original_run(*args, &block)
    end
    result
  end
end