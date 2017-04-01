require 'test_helper'

class FollowshipsControllerTest < ActionController::TestCase
  setup do
    @followship = followships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:followships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create followship" do
    assert_difference('Followship.count') do
      post :create, followship: { followable_id: @followship.followable_id, followable_type: @followship.followable_type, user_id: @followship.user_id }
    end

    assert_redirected_to followship_path(assigns(:followship))
  end

  test "should show followship" do
    get :show, id: @followship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @followship
    assert_response :success
  end

  test "should update followship" do
    patch :update, id: @followship, followship: { followable_id: @followship.followable_id, followable_type: @followship.followable_type, user_id: @followship.user_id }
    assert_redirected_to followship_path(assigns(:followship))
  end

  test "should destroy followship" do
    assert_difference('Followship.count', -1) do
      delete :destroy, id: @followship
    end

    assert_redirected_to followships_path
  end
end
