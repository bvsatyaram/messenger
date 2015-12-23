require 'test_helper'

class Conversation::ThreadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
