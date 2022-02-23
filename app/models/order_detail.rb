class OrderDetail < ApplicationRecord
  # enumuで管理, {0: 製作不可, 1:製作待ち, 2: 製作中, 3: 制作完了}
  enum making_status: { no_making: 0, wating: 1, making: 2, finished: 3 }
end
