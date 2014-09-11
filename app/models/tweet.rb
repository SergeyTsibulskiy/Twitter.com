class Tweet < ActiveRecord::Base
  validates :tweet, presence: true, length: { maximum: 140, minimum: 2 }

  belongs_to :user
end
