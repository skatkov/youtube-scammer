require 'rspec'
require File.dirname(__FILE__) + '/../scammer.rb'

describe "Scammer" do

  it 'properly accept all types of youtube links' do
    correct_links = {
        "ksMSHtqPxPo" => "http://www.youtube.com/watch?v=ksMSHtqPxPo&feature=c4-overview&playnext=1&list=TLz5MOtYmXmaY",
        "0zM3nApSvMg" => "http://www.youtube.com/watch?v=0zM3nApSvMg&feature=feedrec_grec_index",
        "QdK8U-VIH_o" => "http://www.youtube.com/user/IngridMichaelsonVEVO#p/a/u/1/QdK8U-VIH_o",
        "0zM3nApSvMg" => "http://www.youtube.com/v/0zM3nApSvMg?fs=1&amp;hl=en_US&amp;rel=0",
        "0zM3nApSvMg" => "http://www.youtube.com/watch?v=0zM3nApSvMg#t=0m10s",
        "0zM3nApSvMg" => "http://www.youtube.com/embed/0zM3nApSvMg?rel=0",
        "0zM3nApSvMg" => "http://www.youtube.com/watch?v=0zM3nApSvMg",
        "0zM3nApSvMg" => "http://youtu.be/0zM3nApSvMg",
        "QdK8U-VIH_o" => "QdK8U-VIH_o"
    }

    correct_links.keys.each do |key|
      expect(Scammer.find_video_id(correct_links[key])).to eq(key)
    end
  end

  it 'show helps screen' do
    cls = Scammer.new("-h")
    expect(cls.execute).to raise_error(UploadError)
  end
end