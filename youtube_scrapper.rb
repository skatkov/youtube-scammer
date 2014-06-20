

require 'youtube_it'

class YoutubeScrapper
  def initialize(options)
    @channels = options[:channel]
    @videos = options[:video]
  end

  def client
    @client ||=  YouTubeIt::Client.new
  end

  def run
    unless @channels.nil?
      if @channels.kind_of?(Array)
        @channels.each {|ch| client.videos_by(user: ch, most_viewed: TRUE).videos.each {|video| save_data(video)}}
      else
        client.videos_by(user: @channels, most_viewed: TRUE).videos.each {|video| save_data(video)}
      end
    end

    unless @videos.nil?
      if @videos.kind_of?(Array)
        @videos.each {|vdo| save_data(client.video_by(vdo))}
      else
        save_data(client.video_by(@videos))
      end
    end
  end

  private

  def save_data(video)
    Video.update_or_create({id: video.unique_id}, {title: video.title, author: video.author.uri,
                 description: video.description})
    Comment.from_array(client.comments(video.unique_id))
  end
end