require 'pp'
require 'youtube_it'
require_relative 'logging'
Dir['./ext/*.rb'].each { |file| require file }
Dir['./model/*.rb'].each { |file| require file }

class ScammerEngine
  include Scammer::Logging
  attr_reader :comments, :stats, :client

  def initialize(options)
    log.debug("ScammerEngine::new(#{options})")
    @api_key = options[:api_key]
    @scrap_videos = []
    @scrap_videos << options[:video][0].find_video_id unless options[:video].nil?
    @scrap_channels ||= options[:channel][0].find_user_id unless options[:channel].nil?
    @comments = CommentStat.new
  end

  def youtube_client
    @client ||= @api_key.nil? ? YouTubeIt::Client.new : YouTubeIt::Client.new(dev_key: @api_key)
  end

  def find_popular_videos(profile_id)
    video = ProfileVideos.new(youtube_client.videos_by(user: profile_id, most_viewed: TRUE).videos)
    video.popular.each {|v| add_video(v)}
  end

  def add_video(video_id)
    @comments.add_comments(youtube_client.comments(video_id))
  end

  def run
    add_video(@scrap_videos) unless @scrap_videos.empty?
    log.info("ScammerEnginer::run // video list finished, comments: #{@comments.stats}")
    find_popular_videos(@scrap_channels) unless @scrap_channels.nil?
    log.info("ScammerEnginer::run // channels finished, comments: #{@comments.stats}")
    pp @comments
  end
end