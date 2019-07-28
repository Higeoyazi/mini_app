class UsersController < ApplicationController
  def show
    @name = current_user.name
    @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
end