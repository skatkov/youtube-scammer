
class ProfileVideos
  attr_accessor :videos

  def initialize(data)
    @videos = {}
    data.each do |rec|
      @videos[rec.unique_id] = rec.view_count
    end
  end

  def popular
    @videos.values.sort.reverse
  end

end