#!/usr/bin/env ruby
require 'optparse'
require 'pry'
require 'ostruct'
require_relative 'scammer_engine.rb'

class Scammer
  attr_reader :optparse, :arguments, :options

  def initialize(arguments)
    @options = OpenStruct.new(default_config)
    set_option_parser.parse!(check_arguments(arguments))
  end

  def default_config
    {:youtube_login => "lunaticman" }
  end

  def check_arguments(arguments)
    return if arguments.nil?
      if(arguments.size == 1)&&(arguments[0][0]!='-')
        raise OptionParser::InvalidArgument, "Not enough arguments"
      elsif(arguments.kind_of?(String))

	      return arguments.split(/\s{1,}/)
      elsif (arguments.kind_of?(Array))
        return arguments
	    else
        raise OptionParser::InvalidArgument, "Expecting either String or an Array"
      end
  end

  def set_option_parser
    OptionParser.new do |optparser|
      optparser.banner = "Usage: ruby #{File.basename(__FILE__)} [options]"
      optparser.banner = "NB! Youtube links (starting with 'http') accepted as PROFILE/VIDEO_ID"
      optparser.separator("------------------------")

      optparser.on('-p','--profile=[a,b,c]', Array, 'Display active commenters for youtube profile') do |profile|
        puts profile
        @options.profile = profile.collect(&:strip)
      end
      optparser.on('-y', '--youtube=[a,x,y]', Array, 'Display commenter chart for video') do |youtube|

        @options.video = youtube.collect(&:strip)
      end
      #@optparse.on('-f', '--configfile PATH', String, 'Set configuration file') {|path| open_config(path)}
      optparser.on_tail( '-h', '--help', 'Display this screen' ) do
        puts optparser
        exit
      end
    end
  end

  def execute
    dataLayer = ScammerEngine.new(@options)
    dataLayer.run
  end
end

if __FILE__ == $0
  begin
    @cls = Scammer.new(ARGV)
    @cls.execute
  rescue OptionParser::ParseError, OptionParser::InvalidArgument, OptionParser::InvalidOption, OptionParser::MissingArgument
    puts $!.to_s
    puts "Use --help for the force"
    exit
  end
end




