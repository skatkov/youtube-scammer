#!/usr/bin/env ruby
require 'optparse'
require 'pp'
require 'youtube_it'



class Scammer
  attr_reader :optparse, :options, :mandatory,  :arguments

  def initialize(arguments)
    @options = {}
    @optparse = OptionParser.new()
    set_arguments(arguments)
    set_options
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
    @optparse.banner = "Usage: ruby #{File.basename(__FILE__)} youtube_link"

    @optparse.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  def execute
    video_id_regex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/

    if @arguments[0].start_with?("http")
      video_id = @arguments[0].match(video_id_regex)[2]
    else
      #video_id is also accepted
      video_id = @arguments[0]
    end

    pp "type: ", @arguments.class
    #client = YouTubeIt::Client.new
    #pp "comments", client.comments(video_id)
  end
end

if __FILE__ == $0
  cls = Scammer.new(ARGV)
  cls.execute
end




