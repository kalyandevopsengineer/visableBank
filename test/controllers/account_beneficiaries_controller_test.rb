require 'test_helper'

class AccountBeneficiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_beneficiaries_index_url
    assert_response :success
  end

  test "should get show" do
    get account_beneficiaries_show_url
    assert_response :success
  end

  test "should get new" do
    get account_beneficiaries_new_url
    assert_response :success
  end

  test "should get edit" do
    get account_beneficiaries_edit_url
    assert_response :success
  end

  test "should get delete" do
    get account_beneficiaries_delete_url
    assert_response :success
  end

end
