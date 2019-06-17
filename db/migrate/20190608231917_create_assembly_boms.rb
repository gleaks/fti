class CreateAssemblyBoms < ActiveRecord::Migration[5.2]
  def change
    create_table :assembly_boms do |t|
      t.belongs_to :assembly, foreign_key: true
      t.belongs_to :part, foreign_key: true
      t.integer :count
      t.string :refdes, array:true

      t.timestamps
    end
  end
end
