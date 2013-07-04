require_relative "../lib/string.rb"

class CommentStat
  attr_reader :stats

  def initialize
    @stats ||= {}
  end

  def add_comments(data)
    data.each do |comment|
      user = comment.author.name
      if @stats.has_key?(user)
        update_user(user, comment)
      else
        create_new_user(user, comment)
      end
    end
  end

  def update_user(username, comment)
    @stats[username][:count]= @stats[username][:count] + 1
    @stats[username][:reply] =  comment.reply_to.nil? ? @stats[username][:reply]: @stats[username][:reply]+1
  end

  def create_new_user(username, comment)
    @stats[username] = {
        :username =>  comment.author.uri.find_user_id,
        :reply => comment.reply_to.nil? ? 1 : 0,
        :count => 1 }
  end

  def output
    pp "Stats: ", @stats.sort_by{|_key, data| data[:count]}.reverse
  end
end