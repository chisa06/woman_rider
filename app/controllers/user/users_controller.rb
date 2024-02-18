class User::UsersController < ApplicationController

  def show
    @user = current_user
    @tweet = Tweet.new
    @tweets = @user.tweets
  end
end
