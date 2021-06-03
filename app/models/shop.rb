class Shop < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy


  attachment :shop_image

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end


end
