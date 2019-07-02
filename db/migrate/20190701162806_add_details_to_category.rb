class AddDetailsToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :order, :integer
    add_column :categories, :visible, :boolean
    add_column :categories, :color, :string
  end
end
