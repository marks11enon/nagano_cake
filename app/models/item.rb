class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image
  validates :is_active, inclusion: { in: [true, false] }

  scope :active, -> {where(is_active: true)}

  # 消費税を加えた商品価格
  def add_tax_price
    (self.price * 1.1).round
  end

end
