require 'pp'
require 'youtube_it'
Dir['./lib/*.rb'].each{|file| require file}
Dir['./model/*.rb'].each{|file| require file}

class ScammerEngine
  attr_reader :comments, :stats, :client

  def initialize(options)
    @api_key = options[:api_key]
    @scrap_video = []
    @scrap_video << options[:video][0].find_video_id if !options[:video].nil?
    @scrap_profile ||= options[:profile][0].find_user_id if !options[:profile].nil?
    @comments = CommentStat.new
  end

  def youtube_client
    @client ||= @api_key.nil? ? YouTubeIt::Client.new : YouTubeIt::Client.new(:dev_key => @api_key)
  end

  def find_popular_videos(profile_id)
    video = ProfileVideos.new(youtube_client.videos_by(:user => profile_id, :most_viewed => TRUE).videos)
    video.popular.each{|video| add_video(video)}
  end

  def add_video(video_id)
    @comments.add_comments(youtube_client.comments(video_id))
  end

  def run
    add_video(@scrap_video) if !@scrap_video.empty?
    find_popular_videos(@scrap_profile) if !@scrap_profile.nil?
    pp @comments
  end
end