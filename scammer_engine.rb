require 'pp'
require 'youtube_it'
Dir['./lib/*.rb'].each{|file| require file}
Dir['./model/*.rb'].each{|file| require file}

class ScammerEngine
  attr_reader :comments, :stats, :client

  def initialize(options)
    @scrap_video = []
    @scrap_video << options[:video][0].find_video_id if !options[:video].nil?
    @scrap_profile ||= options[:profile][0].find_user_id if !options[:profile].nil?
    @client = connect_youtube(options)
    @comments = CommentStat.new
  end

  def connect_youtube(options)
    options[:api_key].nil? ? YouTubeIt::Client.new : YouTubeIt::Client.new(:dev_key => options[:api_key])
  end

  def find_popular_videos(profile_id)
    video = ProfileVideos.new(@client.videos_by(:user => profile_id, :most_viewed => TRUE).videos)
    video.popular.each{|video| add_video(video)}
  end

  def add_video(video_id)
    @comments.add_comments(@client.comments(video_id))
  end

  def run
    add_video(@scrap_video) if !@scrap_video.empty?
    find_popular_videos(@scrap_profile) if !@scrap_profile.nil?
    pp @comments
  end
end