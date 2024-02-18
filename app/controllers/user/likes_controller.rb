class User::LikesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: tweet.id)
    favorite.save
    redirect_to tweet_path(tweet)
  end

  def destroy
  end
end
