class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :review_text, presence: true, length: { maximum: 200 }

  validates :rate,  presence: true

end
