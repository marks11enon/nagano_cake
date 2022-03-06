class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders
  has_many :addresses
  # 会員フルネーム
  def full_name
    self.last_name + " " + self.first_name
  end
  # 会員フルネーム カナ
  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

  def active_for_authentication?
    super && (self.is_deleted === false)
  end
end
