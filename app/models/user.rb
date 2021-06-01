class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy


  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  #メールアドレスを正規表現のフォームに指定
  validates :postal_code,  presence: true, format: { with: /\A\d{7}\z/ }
  # 退会後のログインを禁止(deviseメソッド)
  def active_for_authentication?
    super && (self.is_valid == true)
  end
  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end
  
end
