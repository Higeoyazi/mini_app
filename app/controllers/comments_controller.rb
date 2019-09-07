class CommentsController < ApplicationController

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.create(comment_params)
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:tweet_id])  }
      format.json
    end
  end

  def edit
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:tweet_id])
    comment = @tweet.comments.find(params[:id])
    @comment = comment.update(comment_params) if comment.user_id == current_user.id
    redirect_to "/tweets/#{@tweet.id}"
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    comment = tweet.comments.find(params[:id])
    comment.destroy if comment.user_id == current_user.id
    redirect_to "/tweets/#{tweet.id}"
    end
  end

private
  def comment_params
    params.require(:comment).permit(:text, :tweet_id).merge(user_id: current_user.id)
  end
