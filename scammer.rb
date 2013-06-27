#!/usr/bin/env ruby
require 'optparse'
require 'youtube_it'
require 'pp'
require File.dirname(__FILE__) + '/scammer_engine.rb'

class Scammer
  attr_reader :optparse, :arguments

  def initialize(arguments)
    @optparse = OptionParser.new()
    set_arguments(arguments)
    set_options
    validate
  end

  def set_arguments(arguments)
    return if arguments.nil?
      if(arguments.kind_of?(String))
	      @arguments = arguments.split(/\s{1,}/)
      elsif (arguments.kind_of?(Array))
	      @arguments = arguments
	    else
        raise Exception, "Expecting either String or an Array"
      end
  end

  def set_options
    @optparse.banner = "Usage: ruby #{File.basename(__FILE__)} http://youtube_link"

    @optparse.on( '-h', '--help', 'Display this screen' ) do
      puts @optparse.help
      exit
    end
  end

  def validate
    begin
      @optparse.parse!(@arguments)
    rescue OptionParser::ParseError, OptionParser::InvalidArgument, OptionParser::InvalidOption, OptionParser::MissingArgument
      puts $!.to_s
      puts @optparse
      exit
    end
  end

  def self.find_video_id(str)
    video_id_regex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    return str.start_with?("http") ? str.match(video_id_regex)[2]: str
  end

  def execute
    client = YouTubeIt::Client.new

    dataLayer = ScammerEngine.new(client.comments(Scammer.find_video_id(@arguments[0])))
    dataLayer.calculate
  end
end

if __FILE__ == $0
  cls = Scammer.new(ARGV)
  cls.execute
end




