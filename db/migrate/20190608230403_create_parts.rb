class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
      t.string :description
      t.string :mfg
      t.string :mfg_id
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
