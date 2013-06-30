class String
  def find_video_id
    video_id_regex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    return self.start_with?("http") ? self.match(video_id_regex)[2]: self.validate_video_id
  end

  def validate_video_id
    raise OptionParser::InvalidArgument, "Incorrect video_id #{self}" if self.size!=11
    return self
  end

  def find_user_id
    self.match(/user\D(\w*)/)[1]
  end
end