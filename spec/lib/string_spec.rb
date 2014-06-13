require_relative '../spec_helper.rb'

describe String do

  it 'should find video_id in youtube links' do
    correct_links = {
        "http://www.youtube.com/watch?v=ksMSHtqPxPo&feature=c4-overview&playnext=1&list=TLz5MOtYmXmaY" => "ksMSHtqPxPo",
        "http://www.youtube.com/watch?v=0zM3nApSvMg&feature=feedrec_grec_index" => "0zM3nApSvMg",
        "http://www.youtube.com/user/IngridMichaelsonVEVO#p/a/u/1/QdK8U-VIH_o" => "QdK8U-VIH_o",
        "http://www.youtube.com/v/0zM3nApSvMg?fs=1&amp;hl=en_US&amp;rel=0" => "0zM3nApSvMg",
        "http://www.youtube.com/watch?v=0zM3nApSvMg#t=0m10s" => "0zM3nApSvMg",
        "http://www.youtube.com/embed/0zM3nApSvMg?rel=0" => "0zM3nApSvMg",
        "http://www.youtube.com/watch?v=0zM3nApSvMg" => "0zM3nApSvMg",
        "http://youtu.be/0zM3nApSvMg" => "0zM3nApSvMg",
        "QdK8U-VIH_o" => "QdK8U-VIH_o"
    }

    correct_links.keys.each do |key|
      key.find_video_id.must_equal correct_links[key]
    end
  end

  it 'should raise error for incorrect youtube_id' do
    incorrect_id = ["QdK8U-VIH_"]
    incorrect_id.each{|id| -> { id.find_video_id }.must_raise(OptionParser::InvalidArgument)}
  end

  it 'should find username from youtube link' do
    profile_link = {"prisonfightorg" => "http://www.youtube.com/user/prisonfightorg",
                    "prisonfightorg1" => "http://gdata.youtube.com/feeds/api/users/prisonfightorg1"}
    profile_link.keys.each do |key|
      profile_link[key].find_user_id.must_equal key
    end
  end

  it "should not filter proper username" do
    "prisonfightorg".find_user_id.must_equal "prisonfightorg"
  end
end