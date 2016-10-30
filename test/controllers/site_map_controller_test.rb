require 'test_helper'

class SiteMapControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_map_index_url
    assert_response :success
  end

end
