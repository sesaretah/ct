require 'test_helper'

class GrantingsControllerTest < ActionController::TestCase
  setup do
    @granting = grantings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grantings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create granting" do
    assert_difference('Granting.count') do
      post :create, granting: { granter_id: @granting.granter_id, role_id: @granting.role_id, user_id: @granting.user_id }
    end

    assert_redirected_to granting_path(assigns(:granting))
  end

  test "should show granting" do
    get :show, id: @granting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @granting
    assert_response :success
  end

  test "should update granting" do
    patch :update, id: @granting, granting: { granter_id: @granting.granter_id, role_id: @granting.role_id, user_id: @granting.user_id }
    assert_redirected_to granting_path(assigns(:granting))
  end

  test "should destroy granting" do
    assert_difference('Granting.count', -1) do
      delete :destroy, id: @granting
    end

    assert_redirected_to grantings_path
  end
end
