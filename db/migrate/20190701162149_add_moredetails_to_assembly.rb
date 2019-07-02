class AddMoredetailsToAssembly < ActiveRecord::Migration[5.2]
  def change
    add_column :assemblies, :current, :boolean
    add_column :assemblies, :order, :integer
  end
end
