require 'test_helper'

class AccesscontrolsControllerTest < ActionController::TestCase
  setup do
    @accesscontrol = accesscontrols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accesscontrols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accesscontrol" do
    assert_difference('Accesscontrol.count') do
      post :create, accesscontrol: { answer_questions: @accesscontrol.answer_questions, ask_questions: @accesscontrol.ask_questions, comment_on_answers: @accesscontrol.comment_on_answers, comment_on_blogs: @accesscontrol.comment_on_blogs, comment_on_events: @accesscontrol.comment_on_events, comment_on_groups: @accesscontrol.comment_on_groups, comment_on_questions: @accesscontrol.comment_on_questions, comment_on_researches: @accesscontrol.comment_on_researches, create_blog: @accesscontrol.create_blog, create_channel: @accesscontrol.create_channel, create_course: @accesscontrol.create_course, create_event: @accesscontrol.create_event, create_good: @accesscontrol.create_good, create_group: @accesscontrol.create_group, create_lab: @accesscontrol.create_lab, create_poll: @accesscontrol.create_poll, create_project: @accesscontrol.create_project, create_research: @accesscontrol.create_research, join_channels: @accesscontrol.join_channels, join_events: @accesscontrol.join_events, join_groups: @accesscontrol.join_groups, rate_researches: @accesscontrol.rate_researches, role_id: @accesscontrol.role_id, search_blogs: @accesscontrol.search_blogs, search_channels: @accesscontrol.search_channels, search_courses: @accesscontrol.search_courses, search_events: @accesscontrol.search_events, search_goods: @accesscontrol.search_goods, search_groups: @accesscontrol.search_groups, search_labs: @accesscontrol.search_labs, search_profiles: @accesscontrol.search_profiles, search_projects: @accesscontrol.search_projects, search_researches: @accesscontrol.search_researches, take_poll: @accesscontrol.take_poll, view_blogs: @accesscontrol.view_blogs, view_channels: @accesscontrol.view_channels, view_courses: @accesscontrol.view_courses, view_events: @accesscontrol.view_events, view_goods: @accesscontrol.view_goods, view_groups: @accesscontrol.view_groups, view_labs: @accesscontrol.view_labs, view_profiles: @accesscontrol.view_profiles, view_projects: @accesscontrol.view_projects, view_questions: @accesscontrol.view_questions, view_researches: @accesscontrol.view_researches }
    end

    assert_redirected_to accesscontrol_path(assigns(:accesscontrol))
  end

  test "should show accesscontrol" do
    get :show, id: @accesscontrol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accesscontrol
    assert_response :success
  end

  test "should update accesscontrol" do
    patch :update, id: @accesscontrol, accesscontrol: { answer_questions: @accesscontrol.answer_questions, ask_questions: @accesscontrol.ask_questions, comment_on_answers: @accesscontrol.comment_on_answers, comment_on_blogs: @accesscontrol.comment_on_blogs, comment_on_events: @accesscontrol.comment_on_events, comment_on_groups: @accesscontrol.comment_on_groups, comment_on_questions: @accesscontrol.comment_on_questions, comment_on_researches: @accesscontrol.comment_on_researches, create_blog: @accesscontrol.create_blog, create_channel: @accesscontrol.create_channel, create_course: @accesscontrol.create_course, create_event: @accesscontrol.create_event, create_good: @accesscontrol.create_good, create_group: @accesscontrol.create_group, create_lab: @accesscontrol.create_lab, create_poll: @accesscontrol.create_poll, create_project: @accesscontrol.create_project, create_research: @accesscontrol.create_research, join_channels: @accesscontrol.join_channels, join_events: @accesscontrol.join_events, join_groups: @accesscontrol.join_groups, rate_researches: @accesscontrol.rate_researches, role_id: @accesscontrol.role_id, search_blogs: @accesscontrol.search_blogs, search_channels: @accesscontrol.search_channels, search_courses: @accesscontrol.search_courses, search_events: @accesscontrol.search_events, search_goods: @accesscontrol.search_goods, search_groups: @accesscontrol.search_groups, search_labs: @accesscontrol.search_labs, search_profiles: @accesscontrol.search_profiles, search_projects: @accesscontrol.search_projects, search_researches: @accesscontrol.search_researches, take_poll: @accesscontrol.take_poll, view_blogs: @accesscontrol.view_blogs, view_channels: @accesscontrol.view_channels, view_courses: @accesscontrol.view_courses, view_events: @accesscontrol.view_events, view_goods: @accesscontrol.view_goods, view_groups: @accesscontrol.view_groups, view_labs: @accesscontrol.view_labs, view_profiles: @accesscontrol.view_profiles, view_projects: @accesscontrol.view_projects, view_questions: @accesscontrol.view_questions, view_researches: @accesscontrol.view_researches }
    assert_redirected_to accesscontrol_path(assigns(:accesscontrol))
  end

  test "should destroy accesscontrol" do
    assert_difference('Accesscontrol.count', -1) do
      delete :destroy, id: @accesscontrol
    end

    assert_redirected_to accesscontrols_path
  end
end
