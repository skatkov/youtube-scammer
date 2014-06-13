require_relative 'spec_helper.rb'
require_relative '../models'

class TestChannel < SequelTestCase

  def test_that_id_can_be_provided
    Channel.create(id: 'testId1', title: 'testTitle')
    Channel.where(title: 'testTitle').count.must_equal 1
  end

  def test_title_cant_be_null
    -> {Channel.create(id:'testId2')}.must_raise Sequel::NotNullConstraintViolation
  end

  def test_default_likeCount_and_descrition
    Channel.create(id:'testId1', title:'testTitle', description: 'test')
    rec = Channel.first(title:'testTitle')
    rec.likeCount.must_equal 0
    rec.description.must_equal 'test'
  end
end