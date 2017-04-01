require 'test_helper'

class PollsectionsControllerTest < ActionController::TestCase
  setup do
    @pollsection = pollsections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollsections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pollsection" do
    assert_difference('Pollsection.count') do
      post :create, pollsection: { poll_id: @pollsection.poll_id, question: @pollsection.question }
    end

    assert_redirected_to pollsection_path(assigns(:pollsection))
  end

  test "should show pollsection" do
    get :show, id: @pollsection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pollsection
    assert_response :success
  end

  test "should update pollsection" do
    patch :update, id: @pollsection, pollsection: { poll_id: @pollsection.poll_id, question: @pollsection.question }
    assert_redirected_to pollsection_path(assigns(:pollsection))
  end

  test "should destroy pollsection" do
    assert_difference('Pollsection.count', -1) do
      delete :destroy, id: @pollsection
    end

    assert_redirected_to pollsections_path
  end
end
