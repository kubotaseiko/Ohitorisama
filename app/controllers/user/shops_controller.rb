class User::ShopsController < ApplicationController

  def index
    @shops = Shop.all
  end

  def show
    @shop= Shop.find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def create
    shop = Shop.new(shop_params)
    shop.user_id = current_user.id
    if shop.save
    redirect_to shops_path
    else
      render 'new'
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    shop = Shop.find(params[:id])
    if shop.update(shop_params)
    redirect_to shop_path(shop.id)
    else
      render 'edit'
    end
  end

  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
    redirect_to shops_path
  end

  def search
  end

  private

  def shop_params
     params.require(:shop).permit(:shop_name, :shop_image, :introduction, :address, :tell, :holiday)
  end

end
