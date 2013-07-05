require_relative 'spec_helper.rb'

def run_engine(options)
  engine = ScammerEngine.new(options)
  engine.calculate
  return engine
end

describe 'ScammerEngine' do
  it 'should accept profile links' do
    engine = run_engine({:profile => ["www.youtube.com/user/prisonfightorg"]})
    engine.comments.stats.class.should be(Hash)
  end

  it 'should accept youtube links' do
    engine = run_engine({:video => ["https://www.youtube.com/watch?v=5rqpdoDv-pI"]})
    engine.comments.stats.class.should be(Hash)
  end
end