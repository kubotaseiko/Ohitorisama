class Shop < ApplicationRecord
  belongs_to :user

  attachment :shop_image


end
