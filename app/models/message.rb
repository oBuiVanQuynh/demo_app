class Message < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order("created_at DESC")}
  validates :content, presence: true, length: {maximum: 1000}
  validates :user_id, presence: true
  scope :chat_with_friend, ->user_id,friend_id{where"((user_id = :user_id and friend_id = :friend_id) OR (user_id = :friend_id and friend_id = :user_id))",user_id: user_id, friend_id: friend_id}
end