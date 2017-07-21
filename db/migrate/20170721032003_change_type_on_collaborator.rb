class ChangeTypeOnCollaborator < ActiveRecord::Migration[5.1]
  def change
    remove_column :collaborators, :owner
    add_column :collaborators, :owner, :integer, default: 0
  end
end
