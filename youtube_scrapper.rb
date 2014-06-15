class YoutubeScrapper
  def initialize(options)
    @scrap_videos = []
    @scrap_videos << options[:video][0].find_video_id unless options[:video].nil?
    @scrap_channels ||= options[:channel][0].find_user_id unless options[:channel].nil?
  end

  def client
    @client ||=  YouTubeIt::Client.new
  end

  def run
    resp = client.videos_by(user: 'prisonfightorg', most_viewed: TRUE)
    resp.videos.each do |video|
      Video.create(id: video.unique_id, title: video.title, author: video.author.uri,
                   description: video.description)
    end
  end
end