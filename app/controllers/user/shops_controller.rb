class User::ShopsController < ApplicationController
  before_action :set_tweet

  def set_tweet
    @tag_list = Tag.includes(:tagmaps).all
    @tweets = Tweet.includes(:user).all
    @tweet = Tweet.new
    if user_signed_in?
      @mytweets = Tweet.where(user_id: current_user.following).or(Tweet.where(user_id: current_user.id))
    end
  end

  def index
    @tag_list = Tag.includes(:tagmaps).all
    @shops = Shop.includes(:reviews).all.page(params[:page]).reverse_order
    @tweets = Tweet.includes(:user).all
    @tweet = Tweet.new

  end

  def show
    @shop = Shop.includes(:user, reviews: :user).find(params[:id])
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
      # params[:shop][:post_image].each do |a|
      #     @post_image = @shop.shop_images.create!(post_image: a, shop_id: @shop.id)
      # end
      redirect_to shops_path
    else
      render 'new'
    end
  end

  def edit
    @shop = Shop.find(params[:id])
    unless user_signed_in? && current_user.id == @shop.user.id
      redirect_to action: :index
    end
  end

  def update
    @shop = Shop.find(params[:id])
    tag_list = params[:shop][:tag_name].split(/[[:blank:]]+/)
    if @shop.update(shop_params)
      @shop.save_tag(tag_list)
      redirect_to shop_path(@shop.id)
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
    split_keyword = params[:keyword].split(/[[:blank:]]+/)
    @shops = []
    split_keyword.each do |keyword|
      next if keyword == ""
      @shops += Shop.joins(tagmaps: :tag).where(["shop_name like? OR address like? OR tag_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    end
    @shops.uniq!
    @shops = Kaminari.paginate_array(@shops).page(params[:page])
    render 'index'
  end

  def rank
    @shops = Shop.all.includes(:reviews).order(rate_average: 'asc').page(params[:page]).reverse_order
    render 'index'
  end

  def hot
    @shops = Shop.joins(:reviews).where(created_at: Date.today.ago(7.days)..Date.today).group(:id).order("count(*) asc").page(params[:page]).reverse_order
    render 'index'
  end


  def tag_search
    @tag_list = Tag.includes(:tagmaps, tagmaps: :shop).all
    @tag = Tag.find(params[:tag_id])
    @shops = @tag.shops.includes(:tagmaps, tagmaps: :tag).all
  end

  private

  def shop_params
     params.require(:shop).permit(:shop_name, :shop_image, :introduction, :address, :tell, :holiday, :latitude, :longitude, :business_hours, post_images_images: [])
  end

end
