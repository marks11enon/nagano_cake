class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :postage, null: false
      t.integer :total, null: false
      t.integer :payment, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
