class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.references :ex_type, index: true
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
