class CreateCamps < ActiveRecord::Migration[5.2]
  def change
    create_table :camps do |t|
      t.string :camp_title
      t.string :camp_type
      t.integer :camp_status
      t.date :applicant_registration_start_date
      t.date :applicant_registration_end_date
      t.time :applicant_registration_start_time
      t.time :applicant_registration_end_time
      t.date :parent_application_start_date
      t.date :parent_application_end_date
      t.time :parent_application_start_time
      t.time :parent_application_end_time

      t.timestamps
    end
  end
end
