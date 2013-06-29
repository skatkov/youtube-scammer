require 'pp'
require 'youtube_it'


class ScammerEngine
  attr_reader :data, :stats, :client

  def initialize
    @stats ||= {}
    @client = YouTubeIt::Client.new
  end

  def youtube_id(video_id)
    @scrap_video ||= video_id
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