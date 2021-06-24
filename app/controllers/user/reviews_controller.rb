class User::ReviewsController < User::ApplicationController

  def index
    @shop = Shop.find(params[:shop_id])
    @review = Review.new
    @reviews = @shop.reviews
    if @shop.reviews.blank?
      @average_review = 0
    else
      @average_review = @shop.reviews.average(:rate).round(2)
    end
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @review = @shop.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      @shop.create_notification_review!(current_user, @review.id)
      @shop.rate_average = Review.where(shop_id: @shop.id).average(:rate)
      @shop.save
    end
  end


  def destroy
    @shop = Shop.find(params[:shop_id])
    @review = Review.find(params[:id])
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:review_text, :rate)
  end

end
