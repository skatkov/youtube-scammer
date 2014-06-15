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
    User.create( username: 'testName' )
    User.first.username.must_equal 'testName'
  end
end

class TestComments < SequelTestCase
  def test_default_likecount
    Comment.create
    Comment.first.likes.must_equal 0
  end

  def test_relationship_with_other_models
    usr = User.create( username: 'user' )
    vdo = Video.create( id: 'youtubeId', title: 'testTitle' )
    usr.add_comment( video_id: vdo.id)
    Comment.first.user_id.must_equal usr.id
    Comment.first.video_id.must_equal vdo.id
  end
end