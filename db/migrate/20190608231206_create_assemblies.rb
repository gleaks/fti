class CreateAssemblies < ActiveRecord::Migration[5.2]
  def change
    create_table :assemblies do |t|
      t.string :name
      t.string :length
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
