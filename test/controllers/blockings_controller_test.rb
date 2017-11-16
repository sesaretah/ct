require 'test_helper'

class BlockingsControllerTest < ActionController::TestCase
  setup do
    @blocking = blockings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blockings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blocking" do
    assert_difference('Blocking.count') do
      post :create, blocking: { blocked_id: @blocking.blocked_id, blocked_type: @blocking.blocked_type, target_id: @blocking.target_id, user_id: @blocking.user_id }
    end

    assert_redirected_to blocking_path(assigns(:blocking))
  end

  test "should show blocking" do
    get :show, id: @blocking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blocking
    assert_response :success
  end

  test "should update blocking" do
    patch :update, id: @blocking, blocking: { blocked_id: @blocking.blocked_id, blocked_type: @blocking.blocked_type, target_id: @blocking.target_id, user_id: @blocking.user_id }
    assert_redirected_to blocking_path(assigns(:blocking))
  end

  test "should destroy blocking" do
    assert_difference('Blocking.count', -1) do
      delete :destroy, id: @blocking
    end

    assert_redirected_to blockings_path
  end
end
