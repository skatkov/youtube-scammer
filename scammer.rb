#!/usr/bin/env ruby
require 'optparse'
require 'pp'
require 'youtube_it'

class Comments
    attr_reader :data, :stats

    def initialize(comments)
      @data ||= comments
      @stats ||= {}
    end

    def calculate

      @data.each do |comment|
        username = comment.author.name

        if !@stats.has_key?(username)
          @stats[username] = 1
        else
          @stats[username] = @stats[comment.author.name] + 1
        end
      end
      pp "Stats: ", @stats
    end
end


class Scammer
  attr_reader :optparse, :options, :mandatory,  :arguments

  def initialize(arguments)
    @options = {}
    @optparse = OptionParser.new()
    set_arguments(arguments)
    set_options
  end

  def set_arguments(arguments)
    pp "Raw arguments: ", arguments

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

  def self.find_video_id(str)
    video_id_regex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    return str.start_with?("http") ? str.match(video_id_regex)[2]: str
  end

  def execute
    client = YouTubeIt::Client.new

    dataLayer = Comments.new(client.comments(Scammer.find_video_id(@arguments[0])))
    dataLayer.calculate
  end
end

if __FILE__ == $0
  cls = Scammer.new(ARGV)
  cls.execute
end




