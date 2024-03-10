class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  self_following_relationships = Relationship.where("follower_id = followed_id")
  self_following_relationships.destroy_all
  
  def self.remove_duplicate_relationships
    Relationship.select(:id, :follower_id, :followed_id)
                .group(:follower_id, :followed_id)
                .having('count(*) > 1')
                .each do |relation|
      # follower_idとfollowed_idが一致するレコードのうち、古い方を削除する
      Relationship.where(follower_id: relation.follower_id, followed_id: relation.followed_id)
                  .order(created_at: :asc)
                  .offset(1)
                  .destroy_all
    end
  end
end
