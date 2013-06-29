#!/usr/bin/env ruby
require 'optparse'
require 'pp'
require File.dirname(__FILE__) + '/scammer_engine.rb'

class Scammer
  attr_reader :optparse, :arguments, :options

  def initialize(arguments)
    @options = {}
    @optparse = OptionParser.new()
    set_options
    begin
      set_arguments(arguments)
      @optparse.parse!(@arguments)
    rescue OptionParser::ParseError, OptionParser::InvalidArgument, OptionParser::InvalidOption, OptionParser::MissingArgument
      puts $!.to_s
      puts @optparse
      exit
    end
  end

  def set_arguments(arguments)
    return if arguments.nil?
      if(arguments.size == 1)
        raise OptionParser::InvalidArgument, "Not enough arguments"
      elsif(arguments.kind_of?(String))
	      @arguments = arguments.split(/\s{1,}/)
      elsif (arguments.kind_of?(Array))
	      @arguments = arguments
	    else
        raise OptionParser::InvalidArgument, "Expecting either String or an Array"
      end
  end

  def set_options
    @optparse.banner = "Usage: ruby #{File.basename(__FILE__)} [options]"

    @optparse.separator("------------------------")

    @optparse.on('-y', '--youtube YOUTUBE_ID', 'Display commenter chart for video') {|youtube|
      @options[:video] = youtube
    }
    @optparse.on_tail( '-h', '--help', 'Display this screen' ) do
      puts @optparse
      exit
    end
  end

  def execute
    @dataLayer = ScammerEngine.new(@options)
    @dataLayer.calculate
  end
end

if __FILE__ == $0
  cls = Scammer.new(ARGV)
  cls.execute
end




