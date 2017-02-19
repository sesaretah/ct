require 'test_helper'

class LabsControllerTest < ActionController::TestCase
  setup do
    @lab = labs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:labs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lab" do
    assert_difference('Lab.count') do
      post :create, lab: { about: @lab.about, address: @lab.address, missions: @lab.missions, name: @lab.name, tel: @lab.tel }
    end

    assert_redirected_to lab_path(assigns(:lab))
  end

  test "should show lab" do
    get :show, id: @lab
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lab
    assert_response :success
  end

  test "should update lab" do
    patch :update, id: @lab, lab: { about: @lab.about, address: @lab.address, missions: @lab.missions, name: @lab.name, tel: @lab.tel }
    assert_redirected_to lab_path(assigns(:lab))
  end

  test "should destroy lab" do
    assert_difference('Lab.count', -1) do
      delete :destroy, id: @lab
    end

    assert_redirected_to labs_path
  end
end
