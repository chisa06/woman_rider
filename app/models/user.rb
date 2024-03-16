class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :directmessages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id
  has_many :following_users, through: :relationships, source: :followed


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/bike_noimage.jpg')
      profile_image.attach(io: File.open(file_path),filename: 'bike_noimage.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user)
    unless self == user
      active_relationships.create(followed_id: user.id)
    end
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_users(search,word)
    if search == "perfect_match"
      User.where("username = ?", word)
    elsif search == "forward_match"
      User.where("username LIKE ?", word + '%')
    elsif search == "backward_match"
      User.where("username LIKE ?", '%' + word)
    else
      User.where("username LIKE ?", '%' + word + '%')
    end
  end


  def following_tweets
    Tweet.where(user_id: following_users.pluck(:id))
  end
end
