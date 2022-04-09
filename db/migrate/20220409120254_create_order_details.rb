class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :item_id
      t.integer :order_id
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :making_status, null: false, default: 0

      t.timestamps
    end
  end
end
