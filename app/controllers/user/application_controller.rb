class User::ApplicationController  < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :search, :rank, :hot]
end