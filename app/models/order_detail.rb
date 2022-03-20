class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # enumuで管理, {0: 着手不可, 1:製作待ち, 2: 製作中, 3: 制作完了}
  enum making_status: { no_making: 0, wating: 1, making: 2, finished: 3 }
end
