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

  it 'should get data from different channel' do
    scrapper({ channel: 'lunaticman'})
    Video.all.count.must_equal 2

  end

  it 'should get all comments from popular videos' do
    Comment.any_instance.stubs(:from_array).returns(nil)
    scrapper({ channel: 'prisonfightorg' })
  end

  it 'should be able to scrap separate video' do
    scrapper({video:'p_i4gAtlQ-M'})
    Video.all.count.must_equal 1
  end

  it 'should accept array of video values' do
    scrapper({video:['p_i4gAtlQ-M', 'OCMFAdX19Bg']})
    Video.all.count.must_equal 2
  end

  it 'should accept array of channel values' do
    scrapper({channel: ['prisonfightorg', 'lunaticman']})
    Video.all.count.must_equal 10
  end
end