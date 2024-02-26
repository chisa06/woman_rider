class User::CommentsController < ApplicationController
  
  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = current_user.comments.new(comment_params)
    comment.tweet_id = tweet.id
    comment.save
    redirect_to tweet_path(tweet)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
