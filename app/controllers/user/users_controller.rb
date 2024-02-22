class User::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweet = Tweet.new
    @tweets = @user.tweets
  end
  
  
end
