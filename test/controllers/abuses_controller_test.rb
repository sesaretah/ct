require 'test_helper'

class AbusesControllerTest < ActionController::TestCase
  setup do
    @abus = abuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abus" do
    assert_difference('Abuse.count') do
      post :create, abus: { title: @abus.title, user_id: @abus.user_id }
    end

    assert_redirected_to abus_path(assigns(:abus))
  end

  test "should show abus" do
    get :show, id: @abus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abus
    assert_response :success
  end

  test "should update abus" do
    patch :update, id: @abus, abus: { title: @abus.title, user_id: @abus.user_id }
    assert_redirected_to abus_path(assigns(:abus))
  end

  test "should destroy abus" do
    assert_difference('Abuse.count', -1) do
      delete :destroy, id: @abus
    end

    assert_redirected_to abuses_path
  end
end
