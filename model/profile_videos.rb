require 'pp'
class ProfileVideos
  attr_accessor :all_videos

  def initialize(data)
    @all_videos = {}
    data.each {|rec|@all_videos[rec.unique_id] = {
        :view_count => rec.view_count,
        :comment_count => rec.comment_count,
        :favorite_count => rec.favorite_count,
        :category => rec.categories[0].label
    } }
  end

  def popular
    @all_videos.sort_by{|_key, value| value[:view_count]}.reverse.take(5)
  end
end