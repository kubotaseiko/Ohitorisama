class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  
  validates :user_id, uniqueness: { scope: :post_id }
  
end
