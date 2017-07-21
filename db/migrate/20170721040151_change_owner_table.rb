class ChangeOwnerTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :collaborators, :owner
    add_column :collaborators, :role, :integer, default: 1
  end
end
