class Admin::ContactsController < ApplicationController

  def index
    @contacts = Contact.all.page(params[:page]).per(10)
  end

end
