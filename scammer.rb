#!/usr/bin/env ruby
require 'optparse'
require_relative 'scammer_engine.rb'

class Scammer
  attr_reader :optparse, :arguments, :options


  def initialize(arguments)
    @options = {}
    @optparse = OptionParser.new()
    set_arguments(arguments)
    open_config("/default.yml")
    set_options
    @optparse.parse!(@arguments)
  end

  def set_arguments(arguments)
    return if arguments.nil?
      if(arguments.size == 1)&&(arguments[0][0]!='-')
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
    @optparse.banner = "NB! Youtube links (starting with 'http') accepted as PROFILE/VIDEO_ID"
    @optparse.separator("------------------------")

    @optparse.on('-f', '--configfile PATH', String, 'Set configuration file') {|path| open_config(path)}
    @optparse.on('-p', '--profile PROFILE', 'Display active commenters for youtube profile') { |profile|
      @options[:profile] = profile
    }
    @optparse.on('-y', '--youtube VIDEO_ID', 'Display commenter chart for video') {|youtube|
      @options[:video] = youtube
    }
    @optparse.on_tail( '-h', '--help', 'Display this screen' ) do
      puts @optparse
      exit
    end
  end

  def open_config(path)
    @options.merge!(Hash[*YAML::load(File.read(File.dirname(__FILE__)+ path))])
  end

  def execute
    @dataLayer = ScammerEngine.new(@options)
    @dataLayer.calculate
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




