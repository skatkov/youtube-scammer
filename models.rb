require 'sequel'
Sequel::Model.plugin(:schema)

DB = ENV['RUBY_ENV'].eql?('test') ? Sequel.sqlite('test.db') : Sequel.sqlite('database.db')
# require 'logging'
# DB.loggers << Logger.new($stdout)

unless DB.table_exists? :video
  DB.create_table :video do
    string      :id, primary_key: true
    string      :title
    string      :author
    text        :description
    DateTime    :published_at
    DateTime    :updated_at
    string      :category
    integer     :views, default: 0
    integer     :likes, default: 0
    integer     :favorites, default: 0
    integer     :dislikes, default: 0
  end
end

unless DB.table_exists? :comment
  DB.create_table :comment do
    foreign_key :video_id, :video, type: String
    foreign_key :user_id, :user, type: String
    integer     :likes, default: 0
  end
end

unless DB.table_exists? (:user)
  DB.create_table :user do
    string      :id, primary_key: true
    string      :username
  end
end

class Video < Sequel::Model(:video)
  unrestrict_primary_key
  many_to_one :channel
  one_to_many :comments
end

class User < Sequel::Model(:user)
  unrestrict_primary_key
  one_to_many :comments
end

class Comment < Sequel::Model(:comment)
  unrestrict_primary_key
  many_to_one :user
  many_to_one :video

  def self.from_object(obj)
    usr = User.find_or_create(id:obj.author.uri.split('/').last, username: obj.author.name)
    vdo = Video.find_or_create(id:obj.url.find_video_id)
    usr.add_comment(video_id: vdo.id)
  end

  def self.from_array(hsh); hsh.each {|obj| Comment.from_object(obj)} end
end
