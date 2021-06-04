class Shop < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  attachment :shop_image

  # mapに使用
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_shop_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_shop_tag
    end
  end

  def self.search(keyword)
    where(["shop_name like? OR address like?", "%#{keyword}%", "%#{keyword}%"])
  end


end
