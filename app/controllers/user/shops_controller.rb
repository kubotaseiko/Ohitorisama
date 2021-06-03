class User::ShopsController < ApplicationController

  def index
    @tag_list = Tag.all
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @shop_tags = @shop.tags
    @user = @shop.user
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.new(shop_params)
    tag_list = params[:shop][:tag_name].split(/[[:blank:]]+/)
    if @shop.save
      @shop.save_tag(tag_list)
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

  def tag_search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @shops = @tag.shops.all
  end

  private

  def shop_params
     params.require(:shop).permit(:shop_name, :shop_image, :introduction, :address, :tell, :holiday)
  end

end
