class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:serch], params[:word])
    else
      @tweets = Tweet.looks(params[:serch], params[:word])
    end
  end
end
