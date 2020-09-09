require 'test_helper'

class CampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camp = camps(:one)
  end

  test "should get index" do
    get camps_url
    assert_response :success
  end

  test "should get new" do
    get new_camp_url
    assert_response :success
  end

  test "should create camp" do
    assert_difference('Camp.count') do
      post camps_url, params: { camp: { applicant_registration_end_date: @camp.applicant_registration_end_date, applicant_registration_end_time: @camp.applicant_registration_end_time, applicant_registration_start_date: @camp.applicant_registration_start_date, applicant_registration_start_time: @camp.applicant_registration_start_time, camp_title: @camp.camp_title, camp_type: @camp.camp_type, parent_application_end_date: @camp.parent_application_end_date, parent_application_end_time: @camp.parent_application_end_time, parent_application_start_date: @camp.parent_application_start_date, parent_application_start_time: @camp.parent_application_start_time } }
    end

    assert_redirected_to camp_url(Camp.last)
  end

  test "should show camp" do
    get camp_url(@camp)
    assert_response :success
  end

  test "should get edit" do
    get edit_camp_url(@camp)
    assert_response :success
  end

  test "should update camp" do
    patch camp_url(@camp), params: { camp: { applicant_registration_end_date: @camp.applicant_registration_end_date, applicant_registration_end_time: @camp.applicant_registration_end_time, applicant_registration_start_date: @camp.applicant_registration_start_date, applicant_registration_start_time: @camp.applicant_registration_start_time, camp_title: @camp.camp_title, camp_type: @camp.camp_type, parent_application_end_date: @camp.parent_application_end_date, parent_application_end_time: @camp.parent_application_end_time, parent_application_start_date: @camp.parent_application_start_date, parent_application_start_time: @camp.parent_application_start_time } }
    assert_redirected_to camp_url(@camp)
  end

  test "should destroy camp" do
    assert_difference('Camp.count', -1) do
      delete camp_url(@camp)
    end

    assert_redirected_to camps_url
  end
end
