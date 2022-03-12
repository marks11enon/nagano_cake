class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image
  validates :is_active, inclusion: { in: [true, false] }

  scope :active, -> {where(is_active: true)}

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end
