class AddNameToRoles < ActiveRecord::Migration[8.0]
  def change
    add_column :roles, :name, :string
  end
end
