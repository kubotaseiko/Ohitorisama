class User::TweetsController < ApplicationController

  def new
    @tweet = Tweet.new
  end

  def create
    @shop = Shop.new
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to user_path(current_user.id)
    else
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_back(fallback_location: root_path)
  end

private
  def tweet_params
    params.require(:tweet).permit(:user_id, :tweet)
  end

end
