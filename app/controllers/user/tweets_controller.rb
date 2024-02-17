class User::TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @tweet.user_id = current_user.id
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to tweets_path
    else
      @tweets = Tweet.all.page(params[:page])
      render :index
    end
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image, :user_id, )
  end
  
end
