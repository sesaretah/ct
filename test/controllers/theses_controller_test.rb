require 'test_helper'

class ThesesControllerTest < ActionController::TestCase
  setup do
    @thesis = theses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:theses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thesis" do
    assert_difference('Thesis.count') do
      post :create, thesis: { advisor_id: @thesis.advisor_id, advisor_utid: @thesis.advisor_utid, faculty: @thesis.faculty, student: @thesis.student, supervisor_id: @thesis.supervisor_id, supervisor_utid: @thesis.supervisor_utid, tdate: @thesis.tdate, thesis_type: @thesis.thesis_type, title: @thesis.title }
    end

    assert_redirected_to thesis_path(assigns(:thesis))
  end

  test "should show thesis" do
    get :show, id: @thesis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @thesis
    assert_response :success
  end

  test "should update thesis" do
    patch :update, id: @thesis, thesis: { advisor_id: @thesis.advisor_id, advisor_utid: @thesis.advisor_utid, faculty: @thesis.faculty, student: @thesis.student, supervisor_id: @thesis.supervisor_id, supervisor_utid: @thesis.supervisor_utid, tdate: @thesis.tdate, thesis_type: @thesis.thesis_type, title: @thesis.title }
    assert_redirected_to thesis_path(assigns(:thesis))
  end

  test "should destroy thesis" do
    assert_difference('Thesis.count', -1) do
      delete :destroy, id: @thesis
    end

    assert_redirected_to theses_path
  end
end
