class User::BookmarksController < User::ApplicationController

  def create
    @shop = Shop.find(params[:shop_id])
    bookmark = @shop.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      @shop.create_notification_bookmark!(current_user)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    bookmark = @shop.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
        bookmark.destroy
    else
        redirect_to request.referer
    end
  end
  
end
