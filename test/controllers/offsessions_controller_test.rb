require 'test_helper'

class OffsessionsControllerTest < ActionController::TestCase
  setup do
    @offsession = offsessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offsessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offsession" do
    assert_difference('Offsession.count') do
      post :create, offsession: { name: @offsession.name, offering_id: @offsession.offering_id }
    end

    assert_redirected_to offsession_path(assigns(:offsession))
  end

  test "should show offsession" do
    get :show, id: @offsession
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offsession
    assert_response :success
  end

  test "should update offsession" do
    patch :update, id: @offsession, offsession: { name: @offsession.name, offering_id: @offsession.offering_id }
    assert_redirected_to offsession_path(assigns(:offsession))
  end

  test "should destroy offsession" do
    assert_difference('Offsession.count', -1) do
      delete :destroy, id: @offsession
    end

    assert_redirected_to offsessions_path
  end
end
