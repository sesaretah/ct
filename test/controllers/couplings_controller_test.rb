require 'test_helper'

class CouplingsControllerTest < ActionController::TestCase
  setup do
    @coupling = couplings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:couplings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupling" do
    assert_difference('Coupling.count') do
      post :create, coupling: { couplee_id: @coupling.couplee_id, couplee_type: @coupling.couplee_type, coupler_id: @coupling.coupler_id, coupler_type: @coupling.coupler_type }
    end

    assert_redirected_to coupling_path(assigns(:coupling))
  end

  test "should show coupling" do
    get :show, id: @coupling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupling
    assert_response :success
  end

  test "should update coupling" do
    patch :update, id: @coupling, coupling: { couplee_id: @coupling.couplee_id, couplee_type: @coupling.couplee_type, coupler_id: @coupling.coupler_id, coupler_type: @coupling.coupler_type }
    assert_redirected_to coupling_path(assigns(:coupling))
  end

  test "should destroy coupling" do
    assert_difference('Coupling.count', -1) do
      delete :destroy, id: @coupling
    end

    assert_redirected_to couplings_path
  end
end
