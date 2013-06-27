require 'pp'

class ScammerEngine
  attr_reader :data, :stats

  def initialize(comments)
    @data ||= comments
    @stats ||= {}
  end

  def calculate
    @data.each do |comment|
      username = comment.author.name
      @stats[username] = !@stats.has_key?(username) ? 1: @stats[username] + 1
    end
    pp "Stats: ", @stats.sort_by{|_key, value| value}.reverse
  end
end