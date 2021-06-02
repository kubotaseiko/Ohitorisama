class User::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @shop = Shop.find(params[:shop_id])
    bookmark = @shop.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    bookmark = @shop.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end
