require 'test_helper'

class PrivacyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get privacy_index_url
    assert_response :success
  end

end
