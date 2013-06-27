class String
  def find_video_id
    video_id_regex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    return self.start_with?("http") ? self.match(video_id_regex)[2]: self
  end
end