require 'test_helper'

class NotificationSettingsControllerTest < ActionController::TestCase
  setup do
    @notification_setting = notification_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notification_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notification_setting" do
    assert_difference('NotificationSetting.count') do
      post :create, notification_setting: { announcement: @notification_setting.announcement, answers_comments: @notification_setting.answers_comments, blog_updates: @notification_setting.blog_updates, channel_updates: @notification_setting.channel_updates, contribution: @notification_setting.contribution, event_updates: @notification_setting.event_updates, group_updates: @notification_setting.group_updates, grouping: @notification_setting.grouping, involvement: @notification_setting.involvement, membership: @notification_setting.membership, messages: @notification_setting.messages, offsession: @notification_setting.offsession, participation: @notification_setting.participation, partnership: @notification_setting.partnership, poll: @notification_setting.poll, project_task: @notification_setting.project_task, question_comments: @notification_setting.question_comments, question_updates: @notification_setting.question_updates, research_comments: @notification_setting.research_comments, research_ranking: @notification_setting.research_ranking, user_id: @notification_setting.user_id }
    end

    assert_redirected_to notification_setting_path(assigns(:notification_setting))
  end

  test "should show notification_setting" do
    get :show, id: @notification_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notification_setting
    assert_response :success
  end

  test "should update notification_setting" do
    patch :update, id: @notification_setting, notification_setting: { announcement: @notification_setting.announcement, answers_comments: @notification_setting.answers_comments, blog_updates: @notification_setting.blog_updates, channel_updates: @notification_setting.channel_updates, contribution: @notification_setting.contribution, event_updates: @notification_setting.event_updates, group_updates: @notification_setting.group_updates, grouping: @notification_setting.grouping, involvement: @notification_setting.involvement, membership: @notification_setting.membership, messages: @notification_setting.messages, offsession: @notification_setting.offsession, participation: @notification_setting.participation, partnership: @notification_setting.partnership, poll: @notification_setting.poll, project_task: @notification_setting.project_task, question_comments: @notification_setting.question_comments, question_updates: @notification_setting.question_updates, research_comments: @notification_setting.research_comments, research_ranking: @notification_setting.research_ranking, user_id: @notification_setting.user_id }
    assert_redirected_to notification_setting_path(assigns(:notification_setting))
  end

  test "should destroy notification_setting" do
    assert_difference('NotificationSetting.count', -1) do
      delete :destroy, id: @notification_setting
    end

    assert_redirected_to notification_settings_path
  end
end
