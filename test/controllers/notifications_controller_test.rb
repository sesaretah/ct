require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  setup do
    @notification = notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notification" do
    assert_difference('Notification.count') do
      post :create, notification: { content: @notification.content, notfiee_id: @notification.notfiee_id, notifiable_id: @notification.notifiable_id, notifiable_type: @notification.notifiable_type, notifiee_type: @notification.notifiee_type, user_id: @notification.user_id }
    end

    assert_redirected_to notification_path(assigns(:notification))
  end

  test "should show notification" do
    get :show, id: @notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notification
    assert_response :success
  end

  test "should update notification" do
    patch :update, id: @notification, notification: { content: @notification.content, notfiee_id: @notification.notfiee_id, notifiable_id: @notification.notifiable_id, notifiable_type: @notification.notifiable_type, notifiee_type: @notification.notifiee_type, user_id: @notification.user_id }
    assert_redirected_to notification_path(assigns(:notification))
  end

  test "should destroy notification" do
    assert_difference('Notification.count', -1) do
      delete :destroy, id: @notification
    end

    assert_redirected_to notifications_path
  end
end
