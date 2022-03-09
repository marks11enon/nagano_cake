class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  scope :active, -> {where(is_active: true)}

end
