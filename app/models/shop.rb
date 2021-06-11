class Shop < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :notifications, dependent: :destroy

  attachment :shop_image


  # =============バリデーション=============
  validates :shop_name, presence: true
  validates :shop_image, presence: true
  validates :introduction, length: { maximum:200 }
  validates :address, presence: true

  # =============GoogleMapに使用=============
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # =============tag関連=============
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

  # =============rate_average=============
 
  # =============検索機能=============
  def self.search(keyword)
    where(["shop_name like? OR address like?", "%#{keyword}%", "%#{keyword}%"])
  end

   # =============bookmark=============
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # =============bookmark通知=============
  def create_notification_bookmark!(current_user)
    # すでに「bookmark」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and shop_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # bookmarkされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        shop_id: id,
        visited_id: user_id,
        action: 'like'
    )
    # 自分の投稿に対するbookmarkの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
      notification.save if notification.valid?
    end
  end
  # =============review通知=============
    def create_notification_review!(current_user, review_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Review.select(:user_id).where(shop_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
       save_notification_review!(current_user, review_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
       save_notification_review!(current_user, review_id, user_id) if temp_ids.blank?
    end

  def save_notification_review!(current_user, review_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      shop_id: id,
      review_id: review_id,
      visited_id: visited_id,
      action: 'review'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end