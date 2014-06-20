class YoutubeScrapper
  def initialize(options)
    @scrap_channels = options[:channel]
  end

  def client
    @client ||=  YouTubeIt::Client.new
  end

  def run
    resp = client.videos_by(user: @scrap_channels, most_viewed: TRUE)
    resp.videos.each do |video|
      Video.create(id: video.unique_id, title: video.title, author: video.author.uri,
                   description: video.description)
      Comment.from_array(client.comments(video.unique_id))
    end
  end
end