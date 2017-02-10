class CreateMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :marks do |t|
      t.references :exerecise
      t.date :acomplished_at, null: false
      t.string :acomplished_in
      t.time :ac_time
      t.float :ac_quantity
      t.integer :ac_reps
      t.integer :ac_xreps

      t.timestamps
    end
  end
end
