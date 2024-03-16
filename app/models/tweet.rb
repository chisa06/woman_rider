class Tweet < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.search_tweets(search, word)
    if search == "perfect_match"
      Tweet.where("content = ?", word)
    elsif search == "forward_match"
      Tweet.where("content LIKE ?", "#{word}%")
    elsif search == "backward_match"
      Tweet.where("content LIKE ?", "%#{word}")
    else
      Tweet.where("content LIKE ?", "%#{word}%")
    end
  end
end
