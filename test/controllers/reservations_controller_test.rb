require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  test "should get seleccionar" do
    get :seleccionar
    assert_response :success
  end

end
