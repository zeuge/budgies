class AddParentsToBudgies < ActiveRecord::Migration
  def change
    add_column :budgies, :father_id, :integer, :default => 0
    add_column :budgies, :mother_id, :integer, :default => 0
  end
end
