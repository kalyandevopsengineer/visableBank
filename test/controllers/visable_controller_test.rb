require 'test_helper'

class VisableControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get visable_index_url
    assert_response :success
  end

end
