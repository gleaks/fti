class CreateVendorparts < ActiveRecord::Migration[5.2]
  def change
    create_table :vendorparts do |t|
      t.references :vendor, foreign_key: true
      t.references :part, foreign_key: true
      t.string :vendor_part
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
