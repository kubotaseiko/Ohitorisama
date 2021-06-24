class User::UsersController < User::ApplicationController

  def show
    @user = User.find(params[:id])
    @shops = @user.shops.includes(:reviews).all.order(created_at: "DESC")
    @bookmarks = Bookmark.includes(:shop,shop: :user).where(user_id: @user.id).page(params[:page]).per(8)
    @tweet = Tweet.new
    @tweets = Tweet.where(user_id: @user.following)
    @mytweets = Tweet.where(user_id: @user.id)
    @reviews = Review.includes(:user, :shop).where(user_id: @user).page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
    unless user_signed_in? && current_user.id == @user.id
      redirect_to user_path(current_user)
    end
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_path(@user.id)
      else
        render 'edit'
      end
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
