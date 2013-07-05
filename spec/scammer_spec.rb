require_relative 'spec_helper.rb'

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

  it 'should accept youtube_id as one option' do
    begin
      Scammer.new(["QdK8U-VIH_o"])
    rescue OptionParser::InvalidArgument => e
      e.should_not be_nil
    end
  end

  it 'should accept Strings' do
    client = Scammer.new(["--youtube=test1234567", "--profile=test01"])
    client.options[:video].should eq(["test1234567"])
    client.options[:profile].should eq(["test01"])
  end

  it 'should accept Array' do
    client = Scammer.new(["--youtube=test1234567,test1234569", "--profile=test01,test02"])
    client.options[:video].should eq(["test1234567", "test1234569"])
    client.options[:profile].should eq(["test01", "test02"])
  end

  it 'it should understand option shortcuts' do
    client = Scammer.new(["-y test1234567", "-p test01"])
    client.options[:video].should eq(["test1234567"])
    client.options[:profile].should eq(["test01"])
  end

  it 'load default settings' do
    client = Scammer.new(["-y test1234567"])
    client.default_config = {:test_config => "alright"}
    client.open_config
    client.options[:test_config].should eq("alright")
  end

end