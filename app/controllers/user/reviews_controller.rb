class User::ReviewsController < ApplicationController

  def create
    @shop = Shop.find(params[:shop_id])
    @review = Review.new
    review = @shop.reviews.new(review_params)
    review.user_id = current_user.id
    if review.save
      redirect_to shop_reviews_path(@shop.id)
    else
      redirect_to shop_path(@shop.id)
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
