class User::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweet = Tweet.new
    @tweets = @user.tweets
    @liked_tweets = @user.likes.map(&:tweet)
    @following_users = @user.following_users
    @followers = @user.followers
    
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
  
  def following
    @user = current_user # ユーザー取得
    @following_users = @user.following # フォローしているユーザーを取得する
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end
  
  

end
