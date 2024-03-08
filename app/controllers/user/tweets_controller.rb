class User::TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @tweet.user_id = current_user.id if current_user
    
    # following_tweetsメソッドを呼び出して結果をログに出力
    @following_tweets = following_tweets

    
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

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  def following_tweets
    @following_users = current_user.following_users
    @following_tweets = Tweet.where(user_id: @following_users.pluck(:id))
  end
  
  def liked_tweets
    @liked_tweets = current_user.likes.map(&:tweet)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image, :user_id)
  end
  
end