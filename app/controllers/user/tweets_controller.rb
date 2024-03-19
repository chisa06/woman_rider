class User::TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @tweet.user_id = current_user.id if current_user
    @tweets = Tweet.order(created_at: :desc)
    
    # following_tweetsメソッドを呼び出して結果をログに出力
    @following_tweets = following_tweets
    @following_tweets = current_user.following_tweets.order(created_at: :desc)
    @user = current_user
    @followers = @user.followers
    
    @comment = Comment.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    
    if params[:tweet][:image].present?
      @tweet.image.attach(params[:tweet][:image])
    end
    
    if @tweet.save
      flash[:notice] = 'You have created book successfully.'
      
      comment_content = params[:tweet][:comment]
      unless comment_content.blank?
        comment = @tweet.comments.new(comment: comment_content)
        comment.user_id = current_user.id
        if comment.save
          flash[:notice] = 'You have created comment successfully.'
        else
          flash[:alert] = 'Failed to create comment.'
        end
      end
      
      redirect_to tweets_path(@tweet)
    else
      @tweets = Tweet.all.page(params[:page])
      render 'tweets/index'
    end
  end

  def show
    @user = current_user
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to tweet_path(tweet.id)
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
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
  
end