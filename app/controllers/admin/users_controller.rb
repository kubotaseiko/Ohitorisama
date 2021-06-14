class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    @users = User.find(params[:id])
  end

end
