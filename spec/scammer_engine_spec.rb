require 'pp'
require_relative 'spec_helper.rb'

def run_engine(options)
  engine = ScammerEngine.new(options)
  engine.run
  return engine
end

describe ScammerEngine do
  describe 'User data retrieval' do
    it 'by channel links' do
      engine = run_engine({:profile => ["www.youtube.com/user/prisonfightorg"]})
      engine.comments.stats.must_be_kind_of Hash
      engine.comments.stats.count.must_equal 57
    end

    it 'by channel name' do
      engine = run_engine({:profile => ["prisonfightorg"]})
      engine.comments.stats.must_be_kind_of Hash
    end

    it 'return error for non-existent channel'
  end

  describe 'Retrive video comments' do
    it 'with youtube links' do
      engine = run_engine({:video => ["https://www.youtube.com/watch?v=5rqpdoDv-pI"]})
      engine.comments.stats.count.must_equal 25
    end

    it 'with video-id' do
      engine = run_engine({:video => ["5rqpdoDv-pI"]})
      engine.comments.stats.count.must_equal 25
    end
  end
end