require 'test_helper'

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get stock_show_url
    assert_response :success
  end

end
