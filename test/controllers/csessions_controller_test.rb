require 'test_helper'

class CsessionsControllerTest < ActionController::TestCase
  setup do
    @csession = csessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:csessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create csession" do
    assert_difference('Csession.count') do
      post :create, csession: { course_id: @csession.course_id, description: @csession.description, title: @csession.title }
    end

    assert_redirected_to csession_path(assigns(:csession))
  end

  test "should show csession" do
    get :show, id: @csession
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @csession
    assert_response :success
  end

  test "should update csession" do
    patch :update, id: @csession, csession: { course_id: @csession.course_id, description: @csession.description, title: @csession.title }
    assert_redirected_to csession_path(assigns(:csession))
  end

  test "should destroy csession" do
    assert_difference('Csession.count', -1) do
      delete :destroy, id: @csession
    end

    assert_redirected_to csessions_path
  end
end
