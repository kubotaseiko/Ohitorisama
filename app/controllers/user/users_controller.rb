class User::UsersController < ApplicationController

def show
  @user = User.find(params[:id])
  @shops = @user.shops.all
end

def edit
end

def update
end

def quit_confirm
end

def quit
end

private


end
