class User::RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_back(fallback_location: root_path)
  end

end
