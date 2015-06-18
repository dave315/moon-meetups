class Meetup < ActiveRecord::Base
  has_many :attendees
  has_many :users, :through => :attendees
  has_many :comments

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
