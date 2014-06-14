require_relative 'spec_helper.rb'

class TestChannel < SequelTestCase
  def test_that_id_can_be_provided
    Channel.create(id: 'testId', title: 'testTitle')
    Channel.where(title: 'testTitle').count.must_equal 1
  end

  def test_title_cant_be_null
    -> {Channel.create(id: 'testId')}.must_raise Sequel::NotNullConstraintViolation
  end

  def test_default_likecount_and_descrition
    Channel.create(id: 'testId',title:'testTitle', description: 'test')
    rec = Channel.first(title:'testTitle')
    rec.likeCount.must_equal 0
    rec.description.must_equal 'test'
  end
end

class TestVideo < SequelTestCase
  def test_relation_channel
    ch = Channel.create(id: 'testId', title: 'testTitle')
    ch.add_video(id:'testId', title: 'testTitle')
    Video.first.channel_id.must_equal ch.id
    ch.videos.count.must_equal 1
  end

  def test_provide_id
    Video.create(id:'testId', title:'testTitle')
    Video.first.id.must_equal 'testId'
  end

  def test_all_params
    Video.create(id:'testId', title: 'testTitle', category: 'testCategory', viewCount: 0, likeCount:0, dislikeCount:0, favoriteCount:0)
    vdo = Video.first
    vdo.title.must_equal 'testTitle'
    vdo.category.must_equal 'testCategory'
    vdo.viewCount.must_equal 0
    vdo.likeCount.must_equal 0
    vdo.dislikeCount.must_equal 0
    vdo.favoriteCount.must_equal 0
  end
end

class TestUser < SequelTestCase
  def test_username
    User.create(username:'testName')
    User.first.username.must_equal 'testName'
  end
end

class TestComments < SequelTestCase
  def test_default_likecount
    Comment.create
    Comment.first.likeCount.must_equal 0
  end

  def test_relationship_with_other_models
    usr = User.create(username:'user')
    vdo = Video.create(id:'youtubeId', title:'testTitle')
    usr.add_comment(video_id: vdo.id)
    Comment.first.user_id.must_equal usr.id
    Comment.first.video_id.must_equal vdo.id
  end
end