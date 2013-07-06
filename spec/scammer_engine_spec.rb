require 'pp'
require_relative 'spec_helper.rb'

def run_engine(options)
  engine = ScammerEngine.new(options)
  engine.run
  return engine
end

describe 'ScammerEngine' do
  context 'User data retrieval' do
    it 'by profile links' do
      engine = run_engine({:profile => ["www.youtube.com/user/prisonfightorg"]})
      engine.comments.stats.class.should be(Hash)
    end

    it 'by profile name' do
      VCR.use_cassette('request by username') do
        engine = run_engine({:profile => ["prisonfightorg"]})
        engine.comments.stats.class.should be(Hash)
      end
    end

    it 'return error if profile is incorrect' do
      VCR.use_cassette('request by username') do
        engine = run_engine({:profile => ["prisonfightorg123"]})
        engine.run
        pp engine.stats
      end
    end
  end

  context 'Retrive video comments' do
    it 'with youtube links' do
      VCR.use_cassette("request_video") do
        engine = run_engine({:video => ["https://www.youtube.com/watch?v=5rqpdoDv-pI"]})
        engine.comments.stats.class.should be(Hash)
      end
    end
    it 'with video-id' do
      VCR.use_cassette("request by video-id") do
        engine = run_engine({:video => ["5rqpdoDv-pI"]})
        engine.comments.stats.class.should be(Hash)
      end
    end
  end

end