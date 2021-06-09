class User::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @shops = @user.shops.all
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @tweet = Tweet.new
    @tweets = Tweet.where(user_id: @user.following).or(Tweet.where(user_id:  @user.id))
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to user_path(@user.id)
  end

  def quit_confirm
  end

  def quit
    current_user.update(is_valid: false)
    sign_out(current_user)
  end

  def followings
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
