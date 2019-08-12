class Api::TweetsController < ApplicationController
  def show
    tweet = Tweet.find(params[:id])
    @comments = tweet.comments.includes(:user).where('id > ?', params[:last_id])
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:id])  }
      format.json
    end
  end
end
