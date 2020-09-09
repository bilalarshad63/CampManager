json.extract! camp, :id, :camp_title, :camp_type,:camp_status, :applicant_registration_start_date, :applicant_registration_end_date, :applicant_registration_start_time, :applicant_registration_end_time, :parent_application_start_date, :parent_application_end_date, :parent_application_start_time, :parent_application_end_time, :created_at, :updated_at
json.url camp_url(camp, format: :json)
