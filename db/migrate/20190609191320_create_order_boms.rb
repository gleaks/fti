class CreateOrderBoms < ActiveRecord::Migration[5.2]
  def change
    create_table :order_boms do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
