require 'test_helper'

class CouchesControllerTest < ActionController::TestCase
  test "should get notificacion" do
    get :notificacion
    assert_response :success
  end

end
