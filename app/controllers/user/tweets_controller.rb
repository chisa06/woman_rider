class User::TweetsController < ApplicationController
  
  def index
    @tweet = Tweet.new
    @tweet.user_id = current_user.id
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweets_path
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image, :user_id, )
  end
  
end
