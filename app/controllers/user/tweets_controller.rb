class User::TweetsController < ApplicationController

  def create
    @shop = Shop.new
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    tweet.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_back(fallback_location: root_path)
  end

private

  def tweet_params
    params.require(:tweet).permit(:tweet)
  end
  
end
