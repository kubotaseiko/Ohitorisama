class ContactMailer < ApplicationMailer
  
  def contact_mail(contact)
    @contact = contact
    mail to: 'kubota712.050@gmail.com', subject: "お問い合わせ"
  end
  
end
