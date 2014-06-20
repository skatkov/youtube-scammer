require_relative '../logging'

class String
  include Scammer::Logging

  def find_video_id
    link_regex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    tag_regex = /video:(.{11})/

    if self.start_with?('http')
      return self.match(link_regex)[2].validate_video_id
    elsif self.start_with?('tag:')
      return self.match(tag_regex)[1].validate_video_id
    else
      return self.validate_video_id
    end
  end

  def find_user_id
    begin
      self.match(/user(s*)\D(\w+)/)[2]
    rescue NoMethodError
      log.debug("String.find_user_id: pattern not mached, return self")
      self
    end
  end

  def validate_video_id
    raise OptionParser::InvalidArgument, "Incorrect video_id #{self}" if self.size != 11
    return self
  end
end