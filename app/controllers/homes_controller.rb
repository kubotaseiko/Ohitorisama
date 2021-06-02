class HomesController < ApplicationController

  def top
    @tweers = Tweet.all
  end

  def about
  end

end
