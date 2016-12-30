require 'test_helper'

class SeekingsControllerTest < ActionController::TestCase
  setup do
    @seeking = seekings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seekings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seeking" do
    assert_difference('Seeking.count') do
      post :create, seeking: { blog_id: @seeking.blog_id, user_id: @seeking.user_id }
    end

    assert_redirected_to seeking_path(assigns(:seeking))
  end

  test "should show seeking" do
    get :show, id: @seeking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seeking
    assert_response :success
  end

  test "should update seeking" do
    patch :update, id: @seeking, seeking: { blog_id: @seeking.blog_id, user_id: @seeking.user_id }
    assert_redirected_to seeking_path(assigns(:seeking))
  end

  test "should destroy seeking" do
    assert_difference('Seeking.count', -1) do
      delete :destroy, id: @seeking
    end

    assert_redirected_to seekings_path
  end
end
