require 'test_helper'

class OffsessionmaterialsControllerTest < ActionController::TestCase
  setup do
    @offsessionmaterial = offsessionmaterials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offsessionmaterials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offsessionmaterial" do
    assert_difference('Offsessionmaterial.count') do
      post :create, offsessionmaterial: { offsession_id: @offsessionmaterial.offsession_id, title: @offsessionmaterial.title }
    end

    assert_redirected_to offsessionmaterial_path(assigns(:offsessionmaterial))
  end

  test "should show offsessionmaterial" do
    get :show, id: @offsessionmaterial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offsessionmaterial
    assert_response :success
  end

  test "should update offsessionmaterial" do
    patch :update, id: @offsessionmaterial, offsessionmaterial: { offsession_id: @offsessionmaterial.offsession_id, title: @offsessionmaterial.title }
    assert_redirected_to offsessionmaterial_path(assigns(:offsessionmaterial))
  end

  test "should destroy offsessionmaterial" do
    assert_difference('Offsessionmaterial.count', -1) do
      delete :destroy, id: @offsessionmaterial
    end

    assert_redirected_to offsessionmaterials_path
  end
end
