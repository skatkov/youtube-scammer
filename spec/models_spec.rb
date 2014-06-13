require_relative 'spec_helper.rb'

class TestChannel < SequelTestCase

  def test_that_id_can_be_provided
    Channel.create(title: 'testTitle')
    Channel.where(title: 'testTitle').count.must_equal 1
  end

  def test_title_cant_be_null
    -> {Channel.create}.must_raise Sequel::NotNullConstraintViolation
  end

  def test_default_likeCount_and_descrition
    Channel.create(title:'testTitle', description: 'test')
    rec = Channel.first(title:'testTitle')
    rec.likeCount.must_equal 0
    rec.description.must_equal 'test'
  end
end

class TestVideo < SequelTestCase
  def test_provide_id
    ch = Channel.create(title: 'testTitle')
    ch.add_video(id:'testId', title: 'testTitle')
    Video.first.id.must_equal 'testId'
  end
end

class TestUser < SequelTestCase
  def test_username
    User.create(username:'testName')
    User.first.username.must_equal 'testName'
  end
end

class TestComments < SequelTestCase
  def test_comments
    Comment.create
    Comment.first.likeCount.must_equal 0
  end
end