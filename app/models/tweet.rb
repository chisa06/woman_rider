class Tweet < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
