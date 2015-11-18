require 'test_helper'

class TipocsControllerTest < ActionController::TestCase
  test "should get gestion" do
    get :gestion
    assert_response :success
  end

end
