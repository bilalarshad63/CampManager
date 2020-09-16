class CreateCampApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :camp_applications do |t|
      t.references :user, foreign_key: true
      t.references :camp, foreign_key: true
      t.string :education
      t.string :social_media
      t.string :technology_requirements
      t.string :camp_preferences

      t.timestamps
    end
  end
end
