class Admin::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @users = User.all.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if @user.is_valid == true
        status = '有効'
      else
        status = '無効'
      end
      flash[:notice] = "ステータスを#{status}に変更しました。"
      redirect_to edit_admin_user_path(@user.id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:is_valid)
  end

end
