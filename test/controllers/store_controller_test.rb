require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select '#columns #side a', minimum: 2
    assert_select '#main .entry', 3
    assert_select 'h3', 'Book One: Great Adventures'
    assert_select '.price', /\£[,\d]+\.\d\d/
  end

end
