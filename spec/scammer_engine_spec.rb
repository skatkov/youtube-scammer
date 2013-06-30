require 'rspec'
require File.dirname(__FILE__) + '/../scammer_engine.rb'

def run_engine(options)
  engine = ScammerEngine.new(options)
  engine.calculate
  return engine
end

describe 'ScammerEngine' do
  it 'should accept profile links' do
    engine = run_engine({:profile => "www.youtube.com/user/prisonfightorg"})
    engine.data.class.should be(Array)
  end

  it 'should accept youtube links' do
    engine = run_engine({:video => "https://www.youtube.com/watch?v=5rqpdoDv-pI"})
    engine.data.class.should be(Array)
  end
end