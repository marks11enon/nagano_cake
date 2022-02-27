class RemoveImageIdFromItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :image_id
  end
end
