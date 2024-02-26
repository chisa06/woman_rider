class Tweet < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @tweet = Tweet.where("content LIKE?","#{word}")
    elsif search == "forward_match"
      @tweet = Tweet.where("content LIKE?","#{word}")
    elsif search == "backward_match"
      @tweet = Tweet.where("content LIKE?","#{word}")
    elsif search == "partial_match"
      @tweet = Tweet.where("content LIKE?","#{word}")
    else
      @tweet = Tweet.all
    end
  end
end
