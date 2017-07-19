class DropCollaboratorsThree < ActiveRecord::Migration[5.1]
  def change
    drop_table :collaborators

  end
end
