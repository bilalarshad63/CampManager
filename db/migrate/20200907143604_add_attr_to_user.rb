class AddAttrToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :education, :string
    add_column :users, :camp_preference, :string
    add_column :users, :tech_reqs, :text
    add_column :users, :gender, :string
  	add_column :users, :date_of_birth, :date
  	add_column :users, :form_count, :integer
  end
end
