class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, length: {is: 7}, presence: true
  validates :address, :name, presence: true

	# 配送先住所情報の結合
	def address_all
	  self.postal_code + " " + self.address + " " + self.name
	end
end
