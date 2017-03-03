require 'test_helper'

class QitemsControllerTest < ActionController::TestCase
  setup do
    @qitem = qitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qitem" do
    assert_difference('Qitem.count') do
      post :create, qitem: { content: @qitem.content, questionaire_id: @qitem.questionaire_id }
    end

    assert_redirected_to qitem_path(assigns(:qitem))
  end

  test "should show qitem" do
    get :show, id: @qitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qitem
    assert_response :success
  end

  test "should update qitem" do
    patch :update, id: @qitem, qitem: { content: @qitem.content, questionaire_id: @qitem.questionaire_id }
    assert_redirected_to qitem_path(assigns(:qitem))
  end

  test "should destroy qitem" do
    assert_difference('Qitem.count', -1) do
      delete :destroy, id: @qitem
    end

    assert_redirected_to qitems_path
  end
end
