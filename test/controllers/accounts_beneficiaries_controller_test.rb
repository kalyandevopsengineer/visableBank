require 'test_helper'

class AccountsBeneficiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accounts_beneficiaries_index_url
    assert_response :success
  end

  test "should get show" do
    get accounts_beneficiaries_show_url
    assert_response :success
  end

  test "should get new" do
    get accounts_beneficiaries_new_url
    assert_response :success
  end

  test "should get edit" do
    get accounts_beneficiaries_edit_url
    assert_response :success
  end

  test "should get delete" do
    get accounts_beneficiaries_delete_url
    assert_response :success
  end

end
