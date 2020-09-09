require "application_system_test_case"

class CampsTest < ApplicationSystemTestCase
  setup do
    @camp = camps(:one)
  end

  test "visiting the index" do
    visit camps_url
    assert_selector "h1", text: "Camps"
  end

  test "creating a Camp" do
    visit camps_url
    click_on "New Camp"

    fill_in "Applicant registration end date", with: @camp.applicant_registration_end_date
    fill_in "Applicant registration end time", with: @camp.applicant_registration_end_time
    fill_in "Applicant registration start date", with: @camp.applicant_registration_start_date
    fill_in "Applicant registration start time", with: @camp.applicant_registration_start_time
    fill_in "Camp title", with: @camp.camp_title
    fill_in "Camp type", with: @camp.camp_type
    fill_in "Parent application end date", with: @camp.parent_application_end_date
    fill_in "Parent application end time", with: @camp.parent_application_end_time
    fill_in "Parent application start date", with: @camp.parent_application_start_date
    fill_in "Parent application start time", with: @camp.parent_application_start_time
    click_on "Create Camp"

    assert_text "Camp was successfully created"
    click_on "Back"
  end

  test "updating a Camp" do
    visit camps_url
    click_on "Edit", match: :first

    fill_in "Applicant registration end date", with: @camp.applicant_registration_end_date
    fill_in "Applicant registration end time", with: @camp.applicant_registration_end_time
    fill_in "Applicant registration start date", with: @camp.applicant_registration_start_date
    fill_in "Applicant registration start time", with: @camp.applicant_registration_start_time
    fill_in "Camp title", with: @camp.camp_title
    fill_in "Camp type", with: @camp.camp_type
    fill_in "Parent application end date", with: @camp.parent_application_end_date
    fill_in "Parent application end time", with: @camp.parent_application_end_time
    fill_in "Parent application start date", with: @camp.parent_application_start_date
    fill_in "Parent application start time", with: @camp.parent_application_start_time
    click_on "Update Camp"

    assert_text "Camp was successfully updated"
    click_on "Back"
  end

  test "destroying a Camp" do
    visit camps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Camp was successfully destroyed"
  end
end
