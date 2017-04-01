require 'test_helper'

class PollitemsControllerTest < ActionController::TestCase
  setup do
    @pollitem = pollitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pollitem" do
    assert_difference('Pollitem.count') do
      post :create, pollitem: { content: @pollitem.content, poll_id: @pollitem.poll_id }
    end

    assert_redirected_to pollitem_path(assigns(:pollitem))
  end

  test "should show pollitem" do
    get :show, id: @pollitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pollitem
    assert_response :success
  end

  test "should update pollitem" do
    patch :update, id: @pollitem, pollitem: { content: @pollitem.content, poll_id: @pollitem.poll_id }
    assert_redirected_to pollitem_path(assigns(:pollitem))
  end

  test "should destroy pollitem" do
    assert_difference('Pollitem.count', -1) do
      delete :destroy, id: @pollitem
    end

    assert_redirected_to pollitems_path
  end
end
