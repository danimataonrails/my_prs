class CreateExTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :ex_types do |t|
      t.string :name, null: false
      t.string :code, limit: 4, null: false
      t.timestamps
    end
  end
end
