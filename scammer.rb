#!/usr/bin/env ruby
require 'optparse'
require 'pp'
require 'ostruct'
require_relative 'logging'
Dir['./ext/*.rb'].each { |file| require file }
require_relative 'models'
require_relative 'youtube_scrapper'

module Scammer
  class Application
    include Scammer::Logging
    attr_reader :optparse, :arguments, :options

    def initialize(arguments)
      log.info( "Arguments: #{arguments}" )
      @options = OpenStruct.new(default_config)
      set_option_parser.parse!(check_arguments(arguments))
    end

    def default_config
      { youtube_login: 'lunaticman' }
    end

    def check_arguments(arguments)
      return if arguments.nil?
      if arguments.size == 1 && arguments[0][0] != '-'
        raise OptionParser::InvalidArgument, 'Not enough arguments'
      elsif arguments.kind_of? String
        return arguments.split(/\s{1,}/)
      elsif arguments.kind_of? Array
        return arguments
      else
        raise OptionParser::InvalidArgument, 'Expecting either String or an Array'
      end
    end

    def set_option_parser
      OptionParser.new do |optparser|
        optparser.banner = "Usage: ruby #{File.basename(__FILE__)} [options]"
        optparser.separator("------------------------")

        optparser.on('-c', '--channel=[a,b,c]', Array, 'Display active commenters for youtube profile') do |channel|
          @options.channel = channel.collect(&:strip).collect{|val| val.find_user_id}
        end
        optparser.on('-y', '--youtube=[a,x,y]', Array, 'Display commenter chart for video') do |youtube|
          @options.video = youtube.collect(&:strip).collect{|val| val.find_video_id}
        end
        # @optparse.on('-f', '--configfile PATH', String, 'Set configuration file') {|path| open_config(path)}
        optparser.on_tail('-h', '--help', 'Display this screen') do
          pp optparser
          exit
        end
      end
    end

    def execute
      YoutubeScrapper.new(@options).run
      pp Comment.all
    end
  end
end

if __FILE__ == $0
  begin
    @cls = Scammer::Application.new(ARGV)
    @cls.execute
  rescue OptionParser::ParseError, OptionParser::InvalidArgument, OptionParser::InvalidOption, OptionParser::MissingArgument
    pp $!.to_s
    pp "Use --help for the force"
    exit
  end
end




