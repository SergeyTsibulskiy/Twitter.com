class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :fullname, length: {minimum: 1}, presence: true

  has_attached_file :avatar, :styles => { :medium => '200x200>', :thumb => '48x48>'},
                    :default_url => '/img/default_profile.png'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :tweets

  has_many :followers

  scope :randomly, -> {order('RAND()')}
end
