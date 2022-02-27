class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependment: :destroy
  has_one_attached :image
  validates :is_active, inculusion: { in: [true, false] }
end
