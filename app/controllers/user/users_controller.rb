class User::UsersController < ApplicationController

  def show
    @tweet = Tweet.find(params[:id])
    @user = current_user
    @tweet = Tweet.new
    @tweets = @user.tweets
  end
end
