class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end

  def search
    @users = User.where('name LIKE(?) and id != ?', "%#{params[:keyword]}%" ,current_user).limit(5)
    respond_to do |format|
      format.html{redirect_to root_path}
      format.json
    end
  end
end
