require_relative 'spec_helper.rb'

class TestVideo < SequelTestCase
  def test_provide_id
    Video.create( id: 'testId', title: 'testTitle' )
    Video.first.id.must_equal 'testId'
  end

  def test_all_params
    Video.create( id: 'testId', title: 'testTitle', category: 'testCategory' )
    vdo = Video.first
    vdo.title.must_equal 'testTitle'
    vdo.category.must_equal 'testCategory'
    vdo.views.must_equal 0
    vdo.likes.must_equal 0
    vdo.dislikes.must_equal 0
    vdo.favorites.must_equal 0
  end
end

class TestUser < SequelTestCase
  def test_username
    User.create( id: 'testId', username: 'testName' )
    User.first.username.must_equal 'testName'
  end
end

class TestComments < SequelTestCase

  def generate_comments(cnt)
    arr = []
    (0...cnt).each do |num|
      author = YouTubeIt::Model::Author.new({name: "chris #{num}", uri: "http://gdata.youtube.com/feeds/api/users/chrudge#{num}"})
      arr << YouTubeIt::Model::Comment.new({content:'test_content', published: Time.now - 86400, title: 'test_title', updated: Time.now, url: "tag:youtube.com,2008:video:TVTw4KIv3Tw:comment:z13nv5jy4vywunrej22lhdxolp2ettiwt04",
                                     reply_to:nil, author: author})
    end
    arr
  end

  def test_default_likecount
    Comment.create
    Comment.first.likes.must_equal 0
  end

  def test_relationship_with_other_models
    usr = User.create( id: 'testUser', username: 'user' )
    vdo = Video.create( id: 'youtubeId', title: 'testTitle' )
    usr.add_comment( video_id: vdo.id)
    Comment.first.user_id.must_equal usr.id
    Comment.first.video_id.must_equal vdo.id
  end

  def test_from_array
    Comment.all.count.must_equal 0
    Comment.from_array('test_od',generate_comments(3))
    Comment.all.count.must_equal 3
  end
end