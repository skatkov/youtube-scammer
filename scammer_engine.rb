require 'pp'
require 'youtube_it'
require File.dirname(__FILE__) + '/lib/string.rb'

class ScammerEngine
  attr_reader :data, :stats, :client

  def initialize(options)
    @scrap_video ||= options[:video].find_video_id
    @stats ||= {}
    @client = YouTubeIt::Client.new
  end

  def calculate
    @data = client.comments(@scrap_video)
    @data.each do |comment|
      username = comment.author.name
      @stats[username] = !@stats.has_key?(username) ? 1: @stats[username] + 1
    end
    pp "Stats: ", @stats.sort_by{|_key, value| value}.reverse
  end
end