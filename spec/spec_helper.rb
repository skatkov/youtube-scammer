require 'minitest/autorun'

Dir['../ext/*.rb'].each { |file| require file }
Dir['../model/*.rb'].each { |file| require file }
require_relative '../scammer.rb'
require_relative '../scammer_engine.rb'

#Test should be quiet
def pp(*args)
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end