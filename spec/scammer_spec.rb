require_relative 'spec_helper.rb'

describe 'Scammer' do
  it 'should not accept only one option' do
    -> { Scammer::Application.new ["error"] }.must_raise(OptionParser::InvalidArgument)
  end

  it 'should accept youtube_id as one option' do
    -> { Scammer::Application.new ["QdK8U-VIH_o"] }.must_raise(OptionParser::InvalidArgument)
  end

  it 'should accept Strings' do
    client = Scammer::Application.new(["--youtube=test1234567", "--profile=test01"])
    client.options[:video].must_equal ["test1234567"]
    client.options[:profile].must_equal ["test01"]
  end

  it 'should accept Array' do
    client = Scammer::Application.new(["--youtube=test1234567,test1234569", "--profile=test01,test02"])
    client.options[:video].must_equal ["test1234567", "test1234569"]
    client.options[:profile].must_equal ["test01", "test02"]
  end

  it 'it should understand option shortcuts' do
    client = Scammer::Application.new(["-y test1234567", "-p test01"])
    client.options[:video].must_equal ["test1234567"]
    client.options[:profile].must_equal ["test01"]
  end
end