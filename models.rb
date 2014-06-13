require 'sequel'


Sequel::Model.plugin(:schema)

DB = ENV['RUBY_ENV'].eql?('test') ? Sequel.sqlite('test.db') : Sequel.sqlite('database.db')
#require_relative 'logger'
#DB.loggers << Logger.new($stdout)

unless DB.table_exists?(:channel)
  DB.create_table :channel do
    primary_key :id
    string      :title, :null => false
    text        :description
    integer     :likeCount, :default => 0
  end
end

class Channel < Sequel::Model(:channel)
  unrestrict_primary_key
  one_to_many :videos
end

unless DB.table_exists? :video
  DB.create_table :video do
    string      :id, :primary_key => true
    string      :title, :null => false
    foreign_key :channel_id, :channel
    text        :description
    DateTime    :publishedAt
    DateTime    :updatedAt
    string      :category
    integer     :viewCount
    integer     :likeCount
    integer     :favoriteCount
    integer     :dislikeCount
  end
end

class Video < Sequel::Model(:video)
  unrestrict_primary_key
  many_to_one :channel
  one_to_many :comments
end

unless DB.table_exists? (:user)
  DB.create_table :user do
    primary_key :id
    string      :username
  end
end

class User < Sequel::Model(:user)
  one_to_many :comments
end

unless DB.table_exists? :comment
  DB.create_table :comment do
    foreign_key :video_id, :video
    foreign_key :user_id, :user
    integer     :likeCount, :default => 0
  end
end

class Comment < Sequel::Model(:comment)
  many_to_one :user
  many_to_one :video
end
