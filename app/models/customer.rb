class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  # 会員フルネーム
  def full_name
    self.last_name + " " + self.first_name
  end
  # 会員フルネーム カナ
  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted === false)
  end

  validates :last_name,  presence: true
  validates :first_name, presence: true
  validates :last_name_kana,  presence: true
  validates :first_name_kana, presence: true
  validates :telephone_number, presence: true
  validates :postal_code,  presence: true
  validates :address, presence: true
end
