require_relative 'spec_helper.rb'
require_relative '../youtube_scrapper'

describe YoutubeScrapper do
  def scrapper(options)
    YoutubeScrapper.new(options).run
  end

  it 'should get most popular videos by channel' do
    scrapper({ channel: 'prisonfightorg' })
    Video.all.count.must_equal 8
  end
end