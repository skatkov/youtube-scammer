require 'pp'
require 'youtube_it'
require File.dirname(__FILE__) + '/lib/string.rb'
require File.dirname(__FILE__) + '/model/profile_videos.rb'
require File.dirname(__FILE__) + '/model/comment_stat.rb'

class ScammerEngine
  attr_reader :data, :stats, :client

  default_config = {
      :api_key => nil,
      :youtube_login => nil
  }

  def initialize(options)
    @scrap_video, @data = [], []
    @scrap_video << options[:video].find_video_id if !options[:video].nil?
    @scrap_profile ||= options[:profile].find_user_id if !options[:profile].nil?
    @stats ||= {}
    @client = YouTubeIt::Client.new
  end

  def find_popular_videos(profile_id)
    video = ProfileVideos.new(@client.videos_by(:user => profile_id, :most_viewed => TRUE).videos)
    video.popular.each{|video| scrap_comments(video)}
  end

  def scrap_comments(video_id)
    @data = @client.comments(video_id)
    @data.each do |comment|
      username = comment.author.name
      @stats[username] = !@stats.has_key?(username) ? 1: @stats[username] + 1
    end
  end

  def calculate
    scrap_comments(@scrap_video) if !@scrap_video.empty?
    find_popular_videos(@scrap_profile) if !@scrap_profile.nil?
    output
  end

  def output
    pp "Stats: ", @stats.sort_by{|_key, value| value}.reverse
  end
end