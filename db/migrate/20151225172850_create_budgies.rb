class CreateBudgies < ActiveRecord::Migration
  def change
    create_table :budgies do |t|
      t.string :name
      t.boolean :gender
      t.references :color, null: false
      t.integer :age
      t.boolean :tribal

      t.timestamps null: false
    end
  end
end
