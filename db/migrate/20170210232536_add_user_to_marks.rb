class AddUserToMarks < ActiveRecord::Migration[5.0]
  def change
    add_column :marks, :user_id, :integer, references: 'users', index: true
  end
end
