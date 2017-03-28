require 'test_helper'

class OperactsControllerTest < ActionController::TestCase
  setup do
    @operact = operacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operact" do
    assert_difference('Operact.count') do
      post :create, operact: { city: @operact.city, country: @operact.country, end_date_j: @operact.end_date_j, start_date_j: @operact.start_date_j, title: @operact.title, user_id: @operact.user_id, utid: @operact.utid }
    end

    assert_redirected_to operact_path(assigns(:operact))
  end

  test "should show operact" do
    get :show, id: @operact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operact
    assert_response :success
  end

  test "should update operact" do
    patch :update, id: @operact, operact: { city: @operact.city, country: @operact.country, end_date_j: @operact.end_date_j, start_date_j: @operact.start_date_j, title: @operact.title, user_id: @operact.user_id, utid: @operact.utid }
    assert_redirected_to operact_path(assigns(:operact))
  end

  test "should destroy operact" do
    assert_difference('Operact.count', -1) do
      delete :destroy, id: @operact
    end

    assert_redirected_to operacts_path
  end
end
