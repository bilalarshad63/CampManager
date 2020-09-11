class AddColsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :education, :string
    add_column :users, :camp_preference, :string
    add_column :users, :tech_reqs, :text
  end
end
