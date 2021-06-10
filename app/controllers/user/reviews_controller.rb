class User::ReviewsController < ApplicationController

  def create
    @shop = Shop.find(params[:shop_id])
    @review = @shop.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      @shop.create_notification_review!(current_user, @review.id)
      redirect_to shop_reviews_path(@shop.id)
    else
      render :index
    end
  end

  def index
    @shop = Shop.find(params[:shop_id])
    @review = Review.new
    if @shop.reviews.blank?
      @average_review = 0
    else
      @average_review = @shop.reviews.average(:rate).round(2)
    end
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to shop_reviews_path(@shop.id)
  end

  private

  def review_params
    params.require(:review).permit(:review_text, :rate)
  end

end
