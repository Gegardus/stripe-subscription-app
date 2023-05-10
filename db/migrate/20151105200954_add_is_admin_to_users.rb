class AddIsAdminToUsers < ActiveRecord::Migration[7.0]s
  def change
    add_column :users, :is_admin, :boolean, null: false, default: false
  end
end
