class User::TweetsController < ApplicationController

  def create
    @shop = Shop.new
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path
    else
      render 'index'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  def tweet_params
     params.permit(:tweet)
  end

end
