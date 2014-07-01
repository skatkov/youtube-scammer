

require 'youtube_it'

class YoutubeScrapper
  def initialize(options)
    @channels = options[:channel]
    @videos = options[:video]
  end

  def run
    unless @channels.nil?
      @channels.kind_of?(Array) ? @channels.each {|ch| fetch_channel(ch)} : fetch_channel(@channel)
    end

    unless @videos.nil?
      @videos.kind_of?(Array) ? @videos.each {|vdo| fetch_video(vdo)} : fetch_video(@videos)
    end
  end

  private

  def client
    @client ||=  YouTubeIt::Client.new
  end

  def fetch_video(video)
    save_data(client.video_by(video))
  end

  def fetch_channel(channel)
    client.videos_by(user: channel, most_viewed: TRUE).videos.each { |video| save_data(video) }
  end

  def save_data(video)
    Video.update_or_create({id: video.unique_id}, {title: video.title, author: video.author.uri,
                 description: video.description})
    Comment.from_array(client.comments(video.unique_id))
  end
end