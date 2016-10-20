require 'test_helper'

class TicketControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ticket_index_url
    assert_response :success
  end

end
