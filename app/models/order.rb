class Order < ApplicationRecord
  # 注文モデル
  enum payment: { credit_card: 0, transfer: 1 }
  # enumで管理, {0: 入金待ち, 1: 入金確認, 2: 製作中, 3: 発送準備中, 4: 発送済み}
  enum status: { wating: 0, paid_up: 1, making: 2, preparing: 3, shipped: 4 }
end
