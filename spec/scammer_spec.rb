require 'rspec'
require File.dirname(__FILE__) + '/../scammer.rb'

def run
  begin
    yield
  rescue SystemExit => e
    e.should be_true
  end
end

describe 'Scammer' do
  it 'show help' do
    run{Scammer.new(["-h"]).should_not raise_error}
  end
  it "should not accept only one option" do
    run {Scammer.new(["error"]).to raise_error}
  end

end