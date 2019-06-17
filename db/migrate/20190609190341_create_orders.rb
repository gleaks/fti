class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.date :date
      t.string :delivery
      t.string :payment
      t.string :warranty
      t.belongs_to :category, foreign_key: true
      t.belongs_to :customer, foreign_key: true

      t.timestamps
    end
  end
end
