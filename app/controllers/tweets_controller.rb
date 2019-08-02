class TweetsController < ApplicationController

  # アバター持ってないとエラーになるから、authenticate_user!
  before_action :authenticate_user!

  # before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(text: tweet_params[:text], user_id: current_user.id)
    redirect_to controller: :tweets, action: :index
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
    redirect_to controller: :tweets, action: :index
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params) if tweet.user_id == current_user.id
    redirect_to controller: :tweets, action: :index
  end
  
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
    @comment = @tweet.comments.new
  end

  private
  def tweet_params
    params.require(:tweet).permit(:text)
  end

  # def move_to_index
  #   redirect_to action: :index unless user_signed_in?
  # end
end
