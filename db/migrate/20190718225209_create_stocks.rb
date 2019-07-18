class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :part, foreign_key: true
      t.references :location, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
