require 'test_helper'

class PartnerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get partner_index_url
    assert_response :success
  end

end
