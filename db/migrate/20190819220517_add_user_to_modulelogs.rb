class AddUserToModulelogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :modulelogs, :user, foreign_key: true
  end
end
