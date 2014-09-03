class Tweet < ActiveRecord::Base
  validates :tweet, presence: true

  belongs_to :user
end
