class User::ShopsController < ApplicationController

  def index
    @tag_list = Tag.includes(:tagmaps).all
    @shops = Shop.includes(:reviews).all.page(params[:page]).reverse_order
    @tweets = Tweet.includes(:user).all
    @tweet = Tweet.new
  end

  def show
    @shop = Shop.includes(reviews: :user).find(params[:id])
    @shop_tags = @shop.tags
    @user = @shop.user
    @review = Review.new
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
    @tag_list = Tag.includes(:tagmaps).all
    @shops = Shop.search(params[:keyword]).page(params[:page]).reverse_order
    @keyword = params[:keyword]
    @tweets = Tweet.includes(:user).all
    @tweet = Tweet.new
    render 'index'
  end

  def tag_search
    @tag_list = Tag.includes(:tagmaps).all
    @tag = Tag.find(params[:tag_id])
    @shops = @tag.shops.includes(:tagmaps).all
  end


  private

  def shop_params
     params.require(:shop).permit(:shop_name, :shop_image, :introduction, :address, :tell, :holiday, :latitude, :longitude)
  end

end
