require 'test_helper'

class MobilesettingsControllerTest < ActionController::TestCase
  setup do
    @mobilesetting = mobilesettings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobilesettings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobilesetting" do
    assert_difference('Mobilesetting.count') do
      post :create, mobilesetting: { access_via_mobile: @mobilesetting.access_via_mobile, securephrase: @mobilesetting.securephrase, user_id: @mobilesetting.user_id }
    end

    assert_redirected_to mobilesetting_path(assigns(:mobilesetting))
  end

  test "should show mobilesetting" do
    get :show, id: @mobilesetting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobilesetting
    assert_response :success
  end

  test "should update mobilesetting" do
    patch :update, id: @mobilesetting, mobilesetting: { access_via_mobile: @mobilesetting.access_via_mobile, securephrase: @mobilesetting.securephrase, user_id: @mobilesetting.user_id }
    assert_redirected_to mobilesetting_path(assigns(:mobilesetting))
  end

  test "should destroy mobilesetting" do
    assert_difference('Mobilesetting.count', -1) do
      delete :destroy, id: @mobilesetting
    end

    assert_redirected_to mobilesettings_path
  end
end
