require 'test_helper'

class StoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get story_index_url
    assert_response :success
  end

end
