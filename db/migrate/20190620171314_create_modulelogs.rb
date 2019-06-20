class CreateModulelogs < ActiveRecord::Migration[5.2]
  def change
    create_table :modulelogs do |t|
      t.integer :serial
      t.string :version
      t.references :order, foreign_key: true
      t.date :date
      t.references :category, foreign_key: true
      t.references :assembly, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
