class AddFieldsToAdmin < ActiveRecord::Migration[5.2]
  def change
  	 add_column :admins, :first_name, :string
  	 add_column :admins, :middle_name, :string
  	 add_column :admins, :last_name, :string
  	 add_column :admins, :phone_number, :string

  end
end
