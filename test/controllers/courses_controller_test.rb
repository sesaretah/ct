require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { course_covered: @course.course_covered, course_field: @course.course_field, course_grade: @course.course_grade, course_points: @course.course_points, course_results: @course.course_results, course_softwares: @course.course_softwares, course_targets: @course.course_targets, course_type: @course.course_type, garding_mechanism: @course.garding_mechanism, lecturer_id: @course.lecturer_id, name: @course.name, problems_period: @course.problems_period }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { course_covered: @course.course_covered, course_field: @course.course_field, course_grade: @course.course_grade, course_points: @course.course_points, course_results: @course.course_results, course_softwares: @course.course_softwares, course_targets: @course.course_targets, course_type: @course.course_type, garding_mechanism: @course.garding_mechanism, lecturer_id: @course.lecturer_id, name: @course.name, problems_period: @course.problems_period }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
