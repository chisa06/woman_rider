class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    if @range == "User"
      @users = User.search_users(@search, @word)
    else
      @tweets = Tweet.search_tweets(@search, @word)
    end
  end
end