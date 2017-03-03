require 'test_helper'

class QuestionairesControllerTest < ActionController::TestCase
  setup do
    @questionaire = questionaires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questionaires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create questionaire" do
    assert_difference('Questionaire.count') do
      post :create, questionaire: { question: @questionaire.question, user_id: @questionaire.user_id }
    end

    assert_redirected_to questionaire_path(assigns(:questionaire))
  end

  test "should show questionaire" do
    get :show, id: @questionaire
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @questionaire
    assert_response :success
  end

  test "should update questionaire" do
    patch :update, id: @questionaire, questionaire: { question: @questionaire.question, user_id: @questionaire.user_id }
    assert_redirected_to questionaire_path(assigns(:questionaire))
  end

  test "should destroy questionaire" do
    assert_difference('Questionaire.count', -1) do
      delete :destroy, id: @questionaire
    end

    assert_redirected_to questionaires_path
  end
end
