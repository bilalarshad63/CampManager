class AddFieldToCampApplications < ActiveRecord::Migration[5.2]
  def change
  	add_column :camp_applications, :education_check, :boolean, default: false
    add_column :camp_applications, :social_media_check, :boolean, default: false
    add_column :camp_applications, :tech_requirements_check, :boolean, default: false
    add_column :camp_applications, :camp_preferences_check, :boolean, default: false
    add_column :camp_applications, :personal_info_check, :boolean, default: false
  end
end
