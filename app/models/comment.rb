class Comment < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  validates :body, presence: true, length: { maximum: 800 }
  validates :user_id, presence: true
  validates :meetup_id, presence: true
end
