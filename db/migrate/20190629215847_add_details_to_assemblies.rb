class AddDetailsToAssemblies < ActiveRecord::Migration[5.2]
  def change
    add_column :assemblies, :spin, :string
    add_column :assemblies, :shortname, :string
    add_column :assemblies, :active, :boolean
  end
end
