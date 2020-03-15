require 'test_helper'

class BeneficiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get beneficiaries_index_url
    assert_response :success
  end

  test "should get show" do
    get beneficiaries_show_url
    assert_response :success
  end

  test "should get new" do
    get beneficiaries_new_url
    assert_response :success
  end

  test "should get edit" do
    get beneficiaries_edit_url
    assert_response :success
  end

  test "should get delete" do
    get beneficiaries_delete_url
    assert_response :success
  end

end
