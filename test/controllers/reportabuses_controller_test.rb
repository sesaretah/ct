require 'test_helper'

class ReportabusesControllerTest < ActionController::TestCase
  setup do
    @reportabus = reportabuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reportabuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reportabus" do
    assert_difference('Reportabuse.count') do
      post :create, reportabus: { abuse_id: @reportabus.abuse_id, abused_id: @reportabus.abused_id, abused_type: @reportabus.abused_type, abuser_id: @reportabus.abuser_id, detail: @reportabus.detail, reporter_id: @reportabus.reporter_id }
    end

    assert_redirected_to reportabus_path(assigns(:reportabus))
  end

  test "should show reportabus" do
    get :show, id: @reportabus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reportabus
    assert_response :success
  end

  test "should update reportabus" do
    patch :update, id: @reportabus, reportabus: { abuse_id: @reportabus.abuse_id, abused_id: @reportabus.abused_id, abused_type: @reportabus.abused_type, abuser_id: @reportabus.abuser_id, detail: @reportabus.detail, reporter_id: @reportabus.reporter_id }
    assert_redirected_to reportabus_path(assigns(:reportabus))
  end

  test "should destroy reportabus" do
    assert_difference('Reportabuse.count', -1) do
      delete :destroy, id: @reportabus
    end

    assert_redirected_to reportabuses_path
  end
end
