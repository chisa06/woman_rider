class User::TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @tweet.user_id = current_user.id if current_user
    
    # following_tweetsメソッドを呼び出して結果をログに出力
    @following_tweets = following_tweets
    @user = current_user
    @followers = @user.followers
    
    
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
    
    tweet = Tweet.find(params[:tweet_id])
    comment = current_user.comments.new(comment_params)
    comment.tweet_id = tweet.id
    comment.save
    redirect_to tweet_path(tweet)
  end

  def show
    @user = current_user
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
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end