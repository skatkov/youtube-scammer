require 'rspec'
require File.dirname(__FILE__) + '/../../model/profile_videos.rb'
require 'yaml'


def open(path)
  YAML.load(File.read(File.dirname(__FILE__) + path))
end


describe 'ProfileVideos' do
  it 'should finds all videos' do
    pp open("/../data/youtube_video.yaml")
  end
end