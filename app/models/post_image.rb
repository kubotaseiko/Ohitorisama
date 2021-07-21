class PostImage < ApplicationRecord
  belongs_to :shop
  attachment :post_image

  validates :post_image, presence: true
end
