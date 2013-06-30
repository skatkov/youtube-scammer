require 'rspec'
require File.dirname(__FILE__) + '/../scammer.rb'


describe 'Scammer' do
  it 'show help' do
    begin
      Scammer.new(["-h"]).should_not raise_error
    rescue SystemExit
    end
  end

  it 'should not accept only one option' do
    begin
      Scammer.new(["error"])
    rescue OptionParser::InvalidArgument => e
      e.should_not be_nil
    end
  end

  it 'should accept Strings' do
    client = Scammer.new(["-y", "test1234567", "-p", "test01"])
    client.options[:video].should eq("test1234567")
    client.options[:profile].should eq("test01")
  end

  it 'should accept Array' do
    client = Scammer.new(["-y", "test1234567", "test1234569", "-p", "test01", "test02"])
    pp client.options
    client.options[:video].should eq(["test1234567", "test1234569"])
    client.options[:profile].should eq(["test01", "test02"])
  end

end