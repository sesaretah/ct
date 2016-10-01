require 'test_helper'

class HonorsControllerTest < ActionController::TestCase
  setup do
    @honor = honors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:honors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create honor" do
    assert_difference('Honor.count') do
      post :create, honor: { title: @honor.title, year: @honor.year }
    end

    assert_redirected_to honor_path(assigns(:honor))
  end

  test "should show honor" do
    get :show, id: @honor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @honor
    assert_response :success
  end

  test "should update honor" do
    patch :update, id: @honor, honor: { title: @honor.title, year: @honor.year }
    assert_redirected_to honor_path(assigns(:honor))
  end

  test "should destroy honor" do
    assert_difference('Honor.count', -1) do
      delete :destroy, id: @honor
    end

    assert_redirected_to honors_path
  end
end
