class Admin::ContactsController < ApplicationController

  def index
    @contacts = Contact.all.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      flash[:notice] = "NO.#{contact.id}を変更しました。"
      redirect_to admin_contacts_path
    end
  end
  
  def contacts_sort
    @contacts = Contact.where(contact_status: params[:keyword]).order(created_at: "DESC").page(params[:page]).per(10)
    render 'index'
  end

  private
  def contact_params
    params.require(:contact).permit(:contact_status)
  end

end
