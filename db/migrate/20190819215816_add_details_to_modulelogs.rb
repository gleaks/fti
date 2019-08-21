class AddDetailsToModulelogs < ActiveRecord::Migration[5.2]
  def change
    add_column :modulelogs, :location, :string
    add_column :modulelogs, :progress, :integer
  end
end
