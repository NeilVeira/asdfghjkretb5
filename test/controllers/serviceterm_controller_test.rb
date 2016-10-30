require 'test_helper'

class ServicetermControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get serviceterm_index_url
    assert_response :success
  end

end
