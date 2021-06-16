class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true

   enum contact_status: {未確認:0, 確認中:1,  済:2, 対応不要:3}

end
